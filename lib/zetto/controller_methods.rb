module Zetto
  module ControllerMethods
    def check_session?(token)
      false
    end

    def create_session_for_user?(user)
      return false unless user.instance_of? Zetto::Config::Params.user_class
      return false if user.new_record?
      Zetto::Seance::SessionRegistration.new(user).execute
    end
  end
end
