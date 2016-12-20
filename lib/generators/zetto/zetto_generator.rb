require 'rails/generators/named_base'

module Zetto
  module Generators
    class ZettoGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers

      namespace "zetto"
      source_root File.expand_path("../templates", __FILE__)

      desc "Create table or add need field if table exist"

      hook_for :orm

    end
  end
end
