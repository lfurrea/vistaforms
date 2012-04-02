# == Schema Information
#
# Table name: form_types
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe FormType do
  before { @formtype = FormType.new(name: "Sole Proprietor")}

  subject { @formtype }

  it { should respond_to(:name) }
  it { should be_valid }

  describe "when name is not present" do
    before { @formtype.name = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @formtype.name = "a" * 51}
    it { should_not be_valid }
  end

end
