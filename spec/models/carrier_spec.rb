# == Schema Information
#
# Table name: carriers
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Carrier do
  before { @carrier = Carrier.new(name: "MVP Direct")}

  subject { @carrier }

  it { should respond_to (:name) }
  it { should respond_to(:forms) }

  describe "when name is not present" do
    before { @carrier.name = " " }

    it { should_not be_valid}
  end

  describe "when name is longer than 50 chars" do
    before { @carrier.name = "a" * 51 }

    it { should_not be_valid}
  end

  describe "form association" do
    before { @carrier.save }
    let!(:older_form) do
      FactoryGirl.create(:form, carrier: @carrier, created_at: 1.day.ago)
    end
    let!(:newer_form) do
      FactoryGirl.create(:form, carrier: @carrier, created_at: 1.hour.ago)
    end

    it "should have the right forms in the right order" do
      @carrier.forms.should == [newer_form, older_form]
    end

    # it "should destroy associated forms" do
    #   forms = @carrier.forms
    #   @carrier.destroy
    #   forms.each do |form|
    #     Form.find_by_id(form.id).should be_nil
    #   end
    # end

  end
end
