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

  it { should respond_to (:name)}

  describe "when name is not present" do
    before { @carrier.name = " " }

    it { should_not be_valid}
  end

  describe "when name is longer than 50 chars" do
    before { @carrier.name = "a" * 51 }

    it { should_not be_valid}
  end
end
