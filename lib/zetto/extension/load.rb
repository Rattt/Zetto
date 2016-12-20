
module Zetto::Extension

  ActiveSupport.on_load :active_record do
    require "zetto/extension/active_record"
    include  Zetto::Extension::ActiveRecord
  end

  ActiveSupport.on_load :action_controller do
    require "zetto/extension/action_controller_base"
    include Zetto::Extension::ActionControllerBase
  end

end




