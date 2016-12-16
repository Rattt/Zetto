require "zetto/controller_methods"

module Zetto

  class Engine < ::Rails::Engine
    isolate_namespace Zetto

    initializer :append_migrations do |app|
      unless app.root.to_s.match(root.to_s)
        config.paths["db/migrate"].expanded.each do |expand_path|
          app.config.paths['db/migrate'] << expand_path
        end
      end
    end

    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end

    ActionController::Base.class_eval do

      require "zetto/config/params"

      require "zetto/storage/common/load"
      require "zetto/storage/connect/load"
      require "zetto/storage/impurety_data/load"
      require "zetto/storage/session/load"

      require "zetto/services/cookie/load"
      require "zetto/services/session/load"

      include Zetto::ControllerMethods

    end
  end

end


