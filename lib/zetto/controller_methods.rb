module Zetto
  module ControllerMethods

    def current_user(cookies)
      return nil unless cookies.class.to_s == "ActionDispatch::Cookies::CookieJar"
      Zetto::Services::Session::GetUser.new(cookies).execute
    end

    def create_session_for_user?(user, cookies)
      return false unless user.class == Zetto::Config::Params.user_class
      return false if user.new_record?
      return false unless cookies.class.to_s == "ActionDispatch::Cookies::CookieJar"
      begin
        Zetto::Services::Session::Registration.new(user, cookies).execute
      rescue ArgumentError
        false
      end
    end

  end
end
