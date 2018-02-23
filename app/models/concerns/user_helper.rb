module UserHelper
  def unverified_access?
    !confirmed? && confirmation_period_valid?
  end

  def sum_children_amount
    amount = children.sum(:amount) / 1000
    "#{children.sum(:amount) / 1000}K USD" unless amount.eql?(0.0)
  end

  def total_children_transactions
    children.map(&:activities).flatten.count
  end
end