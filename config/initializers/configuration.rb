module AllyApi
  class Application < Rails::Application

    # Domain name
    config.domain_name = ENV.fetch('DOMAIN_NAME') { 'ally.vajapravin.com' }

    # Configuration for JWTHandler
    config.jwt = {
      algorithm: ENV.fetch('JWT_ALGORITHM') { 'HS256' },
      secret: Rails.application.secrets.secret_key_base,
      token_expiry_interval: ENV.fetch('JWT_TOKEN_EXPIRY') { 86_400 }.to_i,
      leeway: ENV.fetch('JWT_EXPIRY_LEEWAY') { 30 }.to_i,
      issuer: ENV.fetch('JWT_ISSUER') { config.domain_name }
    }
  end
end