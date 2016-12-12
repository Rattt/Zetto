module Zetto
  module ControllerMethods

    def check_session?(token)
      false
    end

    def create_session_for_user?(user, cookies)
      return false unless user.class == Zetto::Config::Params.user_class
      return false if user.new_record?
      return false unless cookies.class.to_s == "ActionDispatch::Cookies::CookieJar"
      begin
        Zetto::Session::SessionRegistration.new(user, cookies).execute
      rescue ArgumentError
        false
      end
    end

  end
end
