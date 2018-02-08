module ActivityValidators
  def self.included(base)
    base.validate :user_amount, on: :create, unless: :statement?
    base.after_create :adjust_amount, unless: :statement?
  end

  def user_amount
    if withdraw? && user.amount < withdraw_amount
      errors.add(:base, message: I18n.t('error_message.insufficient_amount'))
    end
  end

  def adjust_amount
    remain_amount = user.amount + (withdraw? ? -withdraw_amount : deposit_amount)
    user.update_attributes(amount: remain_amount)
  end
end