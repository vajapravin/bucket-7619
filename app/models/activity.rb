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

class Activity < ApplicationRecord
  include Identifiable, ActivityValidators
  belongs_to :user
  belongs_to :invocation, polymorphic: true
  before_create :validate_active

  attr_accessor :invocation_attributes

  enum event_type: %w(deposit withdraw statement)

  delegate :amount, to: :invocation

  accepts_nested_attributes_for :invocation

  def invocation_attributes=params
    self.invocation = event_type.classify.constantize.new(params)
  end

  def deposit_amount
    deposit? ? amount : nil
  end

  def withdraw_amount
    withdraw? ? amount : nil
  end

  private

  def validate_active
    errors.add(:base, 'User is not active. Kindly contact to your branch executive.') unless user.active
  end
end
