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
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dotamastery
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    config.eager_load_paths += ["#{Rails.root}/lib", "#{Rails.root}/jobs/concerns"]

    config.x.steam_api_key = ENV.fetch('STEAM_API_KEY')
    config.x.valve_cdn_url = ENV.fetch('VALVE_CDN_URL')
    config.x.sidekiq.username = ENV['SIDEKIQ_USERNAME']
    config.x.sidekiq.password = ENV['SIDEKIQ_PASSWORD']

    config.action_dispatch.rescue_responses.merge!(
      'ActionController::UnpermittedParameters' => :bad_request,
      'Pundit::NotAuthorizedError' => :forbidden
    )
  end
end
