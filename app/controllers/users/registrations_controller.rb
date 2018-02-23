class Users::RegistrationsController < Devise::RegistrationsController
  before_action :sign_up_params

  def create
    super
  end

  private

  def sign_up_params
    params[:user] = params[:registration]
    keys = [:profile_attributes => [:identifier, :first_name, :last_name, :address_attributes => [:identifier, :street, :city, :zip, :country, :state, :lat, :lng, :_destroy]]]
    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
  end
end