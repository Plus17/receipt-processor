require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ApplicationName
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
     # We will use the fully-armed and operational power of Postgres",
    # and that means using SQL-based structure.",
    config.active_record.schema_format = :sql

    config.generators do |g|
      # We don't want per-resource stylesheets since
      # that is not how stylesheets work.
      g.stylesheets false

      # We don't want per-resource helpers because
      # helpers are global anyway and we don't want
      # a ton of them.
      g.helper false
    end
  end
end
