# == Schema Information
#
# Table name: deposits
#
#  id         :integer          not null, primary key
#  amount     :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Deposit < ApplicationRecord
  has_one :activity, as: :invocation
end
