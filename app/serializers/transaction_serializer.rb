# == Schema Information
#
# Table name: transactions
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  event_type :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TransactionSerializer < ActiveModel::Serializer
  attributes :id
end
