# == Schema Information
#
# Table name: carriers
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Carrier < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true, length: { maximum: 50}
end
