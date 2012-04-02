# == Schema Information
#
# Table name: form_types
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class FormType < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50 }
end
