# == Schema Information
#
# Table name: applications
#
#  id                            :integer         not null, primary key
#  cu_name                       :string(255)
#  cu_email                      :string(255)
#  created_at                    :datetime        not null
#  updated_at                    :datetime        not null
#  user_id                       :integer
#  form_id                       :integer
#  excel_attachment_file_name    :string(255)
#  excel_attachment_content_type :string(255)
#  excel_attachment_file_size    :integer
#  excel_attachment_updated_at   :datetime
#  filled_pdf_file_name          :string(255)
#  filled_pdf_content_type       :string(255)
#  filled_pdf_file_size          :integer
#  filled_pdf_updated_at         :datetime
#


include ApplicationsHelper

class Application < ActiveRecord::Base
  attr_accessible :cu_name, :cu_email, :form_id, :excel_attachment, :filled_pdf
  belongs_to :form
  belongs_to :user

  validates :cu_name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :cu_email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :user_id, presence: true
  validates :form_id, presence: true
  validates_attachment :excel_attachment, :presence => true,
  :content_type => { :content_type => 'application/vnd.ms-excel' }

  has_attached_file :filled_pdf,
  :storage => :s3,
  :s3_permissions => "authenticated-read",
  :s3_credentials => "#{Rails.root}/config/aws_s3.yml",
  :s3_headers => { 'Content-Disposition' => 'attachment' },
  :url => "s3.amazonaws.com",
  :path => "applications/:id/:basename.:extension",
  :bucket => 'VISTAFORMS'
  has_attached_file :excel_attachment,
  :path => "/tmp/:basename_:id.:extension"


  after_excel_attachment_post_process :extract_values

  def extract_values
    oo = Excel.new(excel_attachment.queued_for_write[:original].path, false, :ignore)
    oo.default_sheet = oo.sheets.first
    excel_mapping = YAML.load_file("#{Rails.root}/config/FdfToExcelMapping.yml")
    imported_attributes = { }
    excel_mapping.each do |field, column|
      value = oo.cell(2, column)
      imported_attributes[field] = value
    end
    self.cu_name = imported_attributes["FirstName"] + " " + imported_attributes["LastName"]
    self.cu_email = imported_attributes["Email"]
    fdf = createFDF(imported_attributes)
    form = Form.find(form_id)

    s3 = AWS::S3.new(YAML.load(File.read("#{Rails.root}/config/aws_s3.yml")))
    t = s3.buckets['PAPERCLIP_VISTAFORMS'].objects[form.pdf_form.path(:original)]
    content = t.read.force_encoding('utf-8')
    form_pdf = File.new("/tmp/form_pdf_" + rand.to_s, "w") << content
    pdf_output = `pdftk #{form_pdf.path} fill_form #{fdf.path} output - flatten`
    tmp_filled_pdf = File.new("/tmp/tmp_filled_pdf_" + rand.to_s, "w") << pdf_output
    timestamp = Time.now.to_s.gsub(/\s/,'_')
    self.filled_pdf = ActionDispatch::Http::UploadedFile.new(filename: "#{form.name}_#{self.cu_name}_#{timestamp}.pdf", type: "application/pdf", head: "Content-Disposition: form-data; name=\"application[filled_pdf]\"; filename=\"#{form.name}_#{self.cu_email}.pdf\"\r\nContent-Type: application/pdf\r\n", tempfile: tmp_filled_pdf)
    tmp_filled_pdf.close
  end

end
