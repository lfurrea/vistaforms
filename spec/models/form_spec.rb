# == Schema Information
#
# Table name: forms
#
#  id                    :integer         not null, primary key
#  name                  :string(255)
#  carrier_id            :integer
#  created_at            :datetime        not null
#  updated_at            :datetime        not null
#  pdf_form_file_name    :string(255)
#  pdf_form_content_type :string(255)
#  pdf_form_file_size    :integer
#

require 'spec_helper'

describe Form do
  #let(:carrier) { FactoryGirl.create(:carrier) }
  #before { @form = Factory.create(:form) }


  #subject { @form }

  #it { should respond_to(:name) }
  #it { should respond_to(:carrier_id) }
  #form.carrier should return its carrier
  #it { should respond_to(:carrier) }
  #its(:carrier) { should == carrier}

  #TODO: Cannot validate attachments yet
  #it { should be_valid}

  # describe "when carrier_id is not present" do
  #   before { @form.carrier_id= nil }
  #   it { should_not be_valid }
  # end

  # describe "when name is not present" do
  #   before { @form.name= nil}
  #   it { should_not be_valid }
  # end

end
