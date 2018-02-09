class API::V1::BaseController < ActionController::API
  before_action :authenticate_user!
  include ResponseHandler#, AllyExceptions
end
