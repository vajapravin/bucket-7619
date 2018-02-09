class Api::V1::CustomersController < API::V1::BaseController
  before_action :validate_role
  before_action :find_customer, only: [:update, :destroy]

  def index
    customers = current_user.customers
    render json: customers
  end

  def create
    customer = current_user.children.new(customer_params)
    render json: customer, status: :ok if customer.save!
  rescue Exception => e
    bad_request(e.message)
  end

  def update
    if @customer.update(customer_params)
      render json: @customer, status: :ok
    else
      bad_request(@customer.errors.full_messages.join(", "))
    end
  end

  private

  def customer_params
    attributes = [:email, :password, :current_password, profile_attributes: [:first_name, :last_name, address_attributes: [:street, :city, :state, :zip, :country, :state, :lat, :lng]]]
    attributes << {roles_attributes: [:name, :id, :_destroy]} if current_user.has_role?(:manager)
    params.require(:user).permit(attributes)
  end

  def validate_role
    return if current_user.has_role?(:manager) || current_user.has_role?(:executive)
    bad_request(I18n.t('error_message.restricted_access'))
  end

  def find_customer
    customers = current_user.has_role?(:manager) ? current_user.descendants : current_user.children
    @customer = customers.where_by_identifier(params[:id]).first
    bad_request(I18n.t('error_message.not_found')) unless @customer
  end
end