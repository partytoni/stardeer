require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Geolocalizz14032017
  class Application < Rails::Application
    config.after_initialize do |app|
      app.routes.append{ match '*a', :to => 'application#render_404' } unless config.consider_all_requests_local
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
