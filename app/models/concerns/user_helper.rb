module UserHelper
  def unverified_access?
    !confirmed? && confirmation_period_valid?
  end
end