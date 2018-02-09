module AllyExceptions
  def self.included(base)
    base.rescue_from StandardError do |exception|
      logger.error exception.message
      render json: ApiResponse.bad(I18n.t('exception_message.something_went_wrong')), status: :internal_server_error
    end

    base.rescue_from ActionController::RoutingError do |exception|
     logger.error exception.message
     render json: ApiResponse.bad(I18n.t('exception_message.not_found')), status: :not_found
    end

    base.rescue_from ActionView::MissingTemplate do |exception|
      logger.error exception.message
      render json: ApiResponse.bad(I18n.t('exception_message.not_found')), status: :not_found
    end

    base.rescue_from ActiveRecord::RecordNotFound do |exception|
      logger.error exception.message
      render json: ApiResponse.bad(I18n.t('exception_message.not_found')), status: :not_found
    end
  end
end