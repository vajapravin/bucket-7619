class Api::V1::MiscController < API::V1::BaseController
  def profile
    render json: current_user
  end
end