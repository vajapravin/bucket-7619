# frozen_string_literal: true
#
module Devise

  #
  module Strategies

    #
    class Token < Base

      def valid?
        request.headers['Authorization'].present?
      end

      def authenticate!
        invalid_token_msg = I18n.t('error_message.invalid_token')
        user = identify_user
        return fail!(invalid_token_msg) if user.nil?
        request.env['devise.skip_trackable'] = true
        success! user
      end

      protected

      def identify_user
        strategy, token = request.headers['Authorization'].split(' ')
        return nil if (strategy || '').casecmp('bearer') != 0

        decoded_token = JWTHandler.decode(token)
        User.find_by(email: decoded_token['email'])
      rescue => e
        logger.error { "Error in token authentication -- #{e.inspect}" }
        nil
      end

    end

  end

end
