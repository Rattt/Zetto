require 'rails/generators/active_record'
require 'generators/zetto/orm_helpers'
require 'zetto/config/params'

module ActiveRecord
  module Generators

    class ZettoGenerator < ActiveRecord::Generators::Base
      argument :attributes, type: :array, default: [], banner: "field:type field:type"

      include Zetto::Generators::OrmHelpers
      source_root File.expand_path("../templates", __FILE__)

      def add_zetto_migration
        if (behavior == :invoke && model_exists?) || (behavior == :revoke && migration_exists?(table_name))
          migration_template "migration_existing.erb", "db/migrate/add_zetto_to_#{table_name}.rb", migration_version: migration_version
        else
          migration_template "migration.erb", "db/migrate/zetto_create_#{table_name}.rb", migration_version: migration_version
        end
      end

      def generate_model
        invoke "active_record:model", [name], migration: false unless model_exists? && behavior == :invoke
      end

      def inject_zetto_model_content
        content = model_contents

        class_path = namespaced? ? class_name.to_s.split("::") : [class_name]

        indent_depth = class_path.size - 1
        content = content.split("\n").map { |line| "  " * indent_depth + line }.join("\n") << "\n"

        inject_into_class(model_path, class_path.last, content) if model_exists?
      end

      def migration_data
        fields = {}
        key = Zetto::Config::Params.user_class_name
        fields[key] = ":string,  :null => false, default: ''"
        key = Zetto::Config::Params.user_class_password
        fields[key] = ":string,  :null => false, default: ''"
        fields
      end

      def rails5?
        Rails.version.start_with? '5'
      end

      def migration_version
        if rails5?
          "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
        end
      end

    end

  end
end
