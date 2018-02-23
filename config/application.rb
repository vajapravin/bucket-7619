require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require_relative '../app/middlewares/devise_params'
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
Dotenv.load("#{ENV['HOME']}/.dotfiles/.ally_env")

module AllyApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    config.action_dispatch.default_headers['X-Frame-Options'] = 'SAMEORIGIN'
    config.action_dispatch.default_headers['X-Xss-Protection'] = '1; mode=block'
    config.action_dispatch.default_headers['X-Content-Type-Options'] = 'nosniff'

    config.to_prepare do
      DeviseController.respond_to :json
    end

    config.eager_load_paths << Rails.root.join('lib')
    config.eager_load_paths << Rails.root.join('app/exceptions')

    # config.middleware.use OverrideDeviseParams, "*"
  end
end
