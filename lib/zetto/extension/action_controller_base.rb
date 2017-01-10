module Zetto::Extension::ActionControllerBase
  extend ActiveSupport::Concern
  require "zetto/config/params"

  require "zetto/storage/common/load"
  require "zetto/storage/connect/load"
  require "zetto/storage/impurety_data/load"
  require "zetto/storage/session/load"

  require "zetto/modules/load"

  require "zetto/services/encryption/load"
  require "zetto/services/cookie/load"
  require "zetto/services/session/load"
  require "zetto/services/authentication/load"


  included do

    def current_user
      begin
        Zetto::Services::Session::GetUser.new(cookies, request.user_agent, request.remote_ip).execute
      rescue ArgumentError => e
        Zetto::Modules::Info.error_message e.message
        Zetto::Modules::Info.error_message I18n.t('exseptions.invalid_arguments', argument: 'Zetto::ControllerMethods', current_method: __method__)
        nil
      rescue Exception => e
        Zetto::Modules::Info.error_message e.message
        Zetto::Modules::Info.error_message I18n.t('exseptions.unknown_error', argument: 'Zetto::ControllerMethods', current_method: __method__)
        nil
      end
    end

    def authorization(class_name, name, password)
      begin
        hashed_password = Zetto::Services::Encryption::PasswordHashing.new(password).execute
        user = Zetto::Services::Authentication::FindUser.new(class_name, name, hashed_password).execute
        return nil if user.nil?
        return nil if user.new_record?
        Zetto::Services::Session::Registration.new(user, cookies, request.user_agent, request.remote_ip).execute
      rescue ArgumentError => e
        Zetto::Modules::Info.error_message e.message
        Zetto::Modules::Info.error_message I18n.t('exseptions.invalid_arguments', argument: 'Zetto::ControllerMethods', current_method: __method__)
        nil
      rescue Exception => e
        Zetto::Modules::Info.error_message e.message
        Zetto::Modules::Info.error_message I18n.t('exseptions.unknown_error', argument: 'Zetto::ControllerMethods', current_method: __method__)
        nil
      end
    end

    def logout
      @cookies[:rembo] = nil
    end

  end

end
