require "zetto/engine"
require "zetto/config/params"

module Zetto

  def self.setup(&block)
    Zetto::Config::Params.set_params(&block)
  end

end
