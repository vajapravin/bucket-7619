class Api::V1::CustomersController < API::V1::BaseController
  before_action :validate_role

  def index
    customers = current_user.customers
    render json: customers
  end

  def create
    customer = current_user.children.new(customer_params)
    if customer.save!
      success(I18n.t("customer.successfully_registered"))
    else
      bad_request(customer.errors)
    end
  rescue Exception => e
    bad_request(e.message)
  end

  private

  def customer_params
    params.require(:user).permit!
  end

  def validate_role
    return if current_user.has_role?(:manager) || current_user.has_role?(:executive)
    bad_request(I18n.t('error_message.restricted_access'))
  end
end