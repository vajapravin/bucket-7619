class Users::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate!(auth_options)

    if resource.confirmed? || resource.unverified_access?
      sign_in(resource_name, resource)
      response.headers[User::TOKEN_HEADER] = JWTHandler.issue_token(email: resource.email)
      resource.resend_confirmation_instructions if resource.unverified_access?
      respond_with resource, location: after_sign_in_path_for(resource)
    else
      resource.resend_confirmation_instructions
      error = { error: I18n.t('devise.failure.verify_email') }
      respond_with error, status: 401, location: after_sign_out_path_for(resource)
    end
  end
end