# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  address_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Profile < ApplicationRecord
  include Identifiable
  has_one :user
  belongs_to :address

  accepts_nested_attributes_for :address

  def fullname
    [first_name, last_name].join(" ")
  end
end
