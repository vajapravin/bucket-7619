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

class ProfileSerializer < ActiveModel::Serializer
  attributes :first_name, :last_name, :identifier, :address

  def address
    AddressSerializer.new(object.address) if object.address
  end
end
