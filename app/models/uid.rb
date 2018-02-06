# == Schema Information
#
# Table name: uids
#
#  id                :integer          not null, primary key
#  identifier        :string
#  identifiable_type :string
#  identifiable_id   :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Uid < ApplicationRecord
  belongs_to :identifiable, polymorphic: true

  before_create :generate_uid

  private

  def generate_uid
    loop do
      self.identifier = SecureRandom.base64.tr('+/=', 'Qrt')
      break unless Uid.exists?(identifier: self.identifier, identifiable_type: self.identifiable_type)
    end
  end
end
