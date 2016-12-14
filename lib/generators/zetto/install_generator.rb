require 'rails/generators'
module Zetto
  class InstallGenerator < Rails::Generators::Base
    desc "Some description of my generator here"

    def self.source_root
      @source_root ||= File.join(File.dirname(__FILE__), 'templates')
    end

    def copy_initializer
      template "zetto.rb", "config/initializers/zetto.rb"
    end

    def rails_4?
      Rails::VERSION::MAJOR == 4
    end

  end
end
