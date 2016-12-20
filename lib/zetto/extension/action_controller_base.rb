module Zetto::Extension::ActionControllerBase

  require "zetto/controller_methods"
  require "zetto/config/params"

  require "zetto/storage/common/load"
  require "zetto/storage/connect/load"
  require "zetto/storage/impurety_data/load"
  require "zetto/storage/session/load"

  require "zetto/services/cookie/load"
  require "zetto/services/session/load"
  require "zetto/services/authentication/load"

  include Zetto::ControllerMethods

end
