
module Zetto::Extension

  ActiveSupport.on_load :active_record do
    require "zetto/extension/active_record"
    include  Zetto::Extension::ActiveRecord
  end

  ActiveSupport.on_load :action_controller do
    require "zetto/extension/action_controller_base"
    include Zetto::Extension::ActionControllerBase
  end

=begin
  ActiveSupport.on_load :active_model do
    require "zetto/extension/validators/check_password"
    include Zetto::Extension::Validators
  end
=end

end




