# frozen_string_literal: true

require 'jwt'

#
module JWTHandler

  #
  class << self

    def config
      Rails.application.config.jwt
    end

    def issue_token(data)
      payload = {
        data: data,
        iss: config[:issuer],
        exp: Time.now.to_i + config[:token_expiry_interval],
        iat: Time.now.to_i
      }

      JWT.encode(payload, config[:secret], config[:algorithm])
    end

    def decode(token)
      decoded = JWT.decode(token, config[:secret], true,
                           leeway: config[:leeway], algorithm: config[:algorithm], iss: config[:issuer],
                           verify_iss: true, verify_iat: true)
      decoded[0]['data']
    end

  end

end
