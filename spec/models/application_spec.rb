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

require 'spec_helper'

describe Application do

  before do
    @user = User.create(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
    @form = Form.first
    @application = @user.applications.build(cu_name: "William Rosvally", cu_email: "william@example.com", :form_id => 1)
  end
  subject { @application }

  it { should respond_to :cu_name }
  it { should respond_to :cu_email }
  it { should respond_to :form_id}
  it { should respond_to :user_id}
  its (:user_id)  { should == @user.id }
  #TODO: still cannot create forms in test environment
  #the following test is useless
  its (:form_id) { should == 1}

  describe "when cu_name is not present" do
    before { @application.cu_name =" "}
    it { should_not be_valid}
  end

  describe "when cu_email is not present" do
    before { @application.cu_email = " "}
    it { should_not be_valid}
  end

  describe "when user_id is not present" do
    before { @application.user_id = nil }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @application.cu_name = "a" * 51}
    it { should_not be_valid}
  end

  describe "when email address is not valid" do
    invalid_addresses = %w[customer@foo,com user_at_foo.org example.user@foo.]
    invalid_addresses.each do |invalid_address|
      before { @application.cu_email = invalid_address }
      it { should_not be_valid }
    end
  end

  describe "when email address is valid" do
    valid_addresses = %w[customer@foo.com A_Customer@f.b.org frst.lst@foo.jp a+b@baz.cn]
    valid_addresses.each do |valid_address|
      before { @application.cu_email= valid_address }
      it { should be_valid }
    end
  end

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Application.new(user_id: @user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

end
