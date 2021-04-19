require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.


module SampleApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    Bundler.require(*Rails.groups)
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

    config.i18n.available_locales = [:en, :vi]
    config.i18n.default_locale = :vi
    # Include the authenticity token in remote forms.
    config.action_view.embed_authenticity_token_in_remote_forms = true

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.before_configuration do
    env_file = File.join(Rails.root, 'config', 'application.yml')
    YAML.load(File.open(env_file)).each do |key, value|
    ENV[key.to_s] = value
    end if File.exists?(env_file)
    # config/application.rb
    config.assets.initialize_on_precompile = false
end


  end
end
