# == Schema Information
#
# Table name: activities
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  event_type      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  invocation_type :string
#  invocation_id   :integer
#

class ActivitySerializer < ActiveModel::Serializer
  attributes :identifier, :event_type, :invocation_id, :invocation_type
  belongs_to :invocation, key: :invocation_attributes
end
