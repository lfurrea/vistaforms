# == Schema Information
#
# Table name: forms
#
#  id                                 :integer         not null, primary key
#  name                           :string(255)
#  carrier_id                      :integer
#  created_at                    :datetime        not null
#  updated_at                   :datetime        not null
#  pdf_form_file_name      :string(255)
#  pdf_form_content_type :string(255)
#  pdf_form_file_size         :integer
#

class Form < ActiveRecord::Base
  attr_accessible :name, :carrier_id, :pdf_form
  belongs_to :carrier, dependent: :destroy

  validates :carrier_id, presence: true
  validates :name, presence: true, length: { maximum: 80 }
  validates_attachment :pdf_form, :presence => true,
  :content_type => { :content_type => "application/pdf"}
  default_scope order: 'forms.created_at DESC'
  has_attached_file :pdf_form,
  :storage => :s3,
  :s3_credentials => "#{Rails.root}/config/aws_s3.yml",
  :s3_headers => { 'Content-Disposition' => 'attachment' },
  :url => "s3.amazonaws.com",
  :path => "forms/:id/:style/:basename.:extension",
  :bucket => 'PAPERCLIP_VISTAFORMS',
  :styles => {
    :preview => { :geometry => '135', :format => :png}}

  after_save :fix_thumbnail

  def fix_thumbnail(force = false)
    return unless force or pdf_form_content_type.include?('pdf')

    s3 = AWS::S3.new(YAML.load(File.read("#{Rails.root}/config/aws_s3.yml")))
    t = s3.buckets['PAPERCLIP_VISTAFORMS'].objects[pdf_form.path(:preview)]
    content = t.read
    t.write(:data => content, :content_type => 'image/png', :content_disposition => 'inline', :acl => :public_read)
    nil
  end

end
