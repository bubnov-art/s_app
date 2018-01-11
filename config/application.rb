require_relative 'boot'

require 'rails/all'
# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
module DnaTest
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.time_zone = "Moscow"
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ru
    config.action_dispatch.default_headers.merge!('Content-Type' => 'text/html; charset=UTF-8')
    config.action_dispatch.default_headers.merge!('X-UA-Compatible' => 'IE=Edge')
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'local_env.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end
  end
end
