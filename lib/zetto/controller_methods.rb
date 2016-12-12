module Zetto
  module ControllerMethods

    def current_user
      Zetto::Services::Session::GetUser.new(cookies).execute
    end

    def create_session_for_user?(user)
      return false unless user.class == Zetto::Config::Params.user_class
      return false if user.new_record?
      begin
        Zetto::Services::Session::Registration.new(user, cookies).execute
      rescue ArgumentError
        false
      end
    end

  end
end
