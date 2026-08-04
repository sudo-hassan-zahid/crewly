require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module HrmsRor
  class Application < Rails::Application
    config.load_defaults 7.1

    # Configuration for the application, engines, and railties goes here.
    config.time_zone = "UTC"
    config.autoload_paths += %W(#{config.root}/app/services #{config.root}/app/policies)

    # Don't generate system test files
    config.generators.system_tests = nil
  end
end
