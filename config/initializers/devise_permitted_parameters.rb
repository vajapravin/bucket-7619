# frozen_string_literal: true
# Devise mixin for controllers
module DevisePermittedParameters

  extend ActiveSupport::Concern

  included do
    before_action :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    keys = [:profile_attributes => [:identifier, :first_name, :last_name, :address_attributes => [:identifier, :street, :city, :zip, :country, :state, :lat, :lng, :_destroy]]]
    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
    devise_parameter_sanitizer.permit(:account_update, keys: keys)
  end

end

DeviseController.send :include, DevisePermittedParameters
