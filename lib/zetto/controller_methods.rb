module Zetto
  module ControllerMethods

    def check_session?(token)
      false
    end

    def create_session_for_user?(user)
      return false unless user.class == Zetto::Config::Params.user_class
      return false if user.new_record?
      begin
        Zetto::Session::SessionRegistration.new(user).execute
      rescue ArgumentError
        false
      end
    end

  end
end
