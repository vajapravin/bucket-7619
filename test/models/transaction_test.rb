# == Schema Information
#
# Table name: transactions
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  event_type      :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  invocation_type :string
#  invocation_id   :integer
#

require 'test_helper'

class TransactionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
