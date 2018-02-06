# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  street     :string
#  city       :string
#  zip        :integer
#  country    :string
#  state      :string
#  lat        :float
#  lng        :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AddressSerializer < ActiveModel::Serializer
  attributes :identifier, :street, :city, :zip, :country, :state, :lat, :lng
end
