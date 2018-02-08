# == Schema Information
#
# Table name: withdraws
#
#  id         :integer          not null, primary key
#  amount     :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Withdraw < ApplicationRecord
  has_one :activity, as: :invocation
end
