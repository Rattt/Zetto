require "zetto/engine"
require "zetto/config/params"

module Zetto

  def self.setup(&block)
    I18n.load_path += Dir[File.join(File.dirname(__FILE__), 'zetto/locales', '*.yml').to_s]
    Zetto::Config::Params.set_params(&block)
  end

end
