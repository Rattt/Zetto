module Zetto
  module ControllerMethods

    def current_user
      begin
        Zetto::Services::Session::GetUser.new(cookies).execute
      rescue ArgumentError
        puts 'Invalid input arguments Zetto::ControllerMethods #current_user'
        nil
      rescue
        puts 'An error occurred Zetto::ControllerMethods #current_user'
        nil
      end
    end

    def create_session_for_user(user)
      return false unless user.class == Zetto::Config::Params.user_class
      return false if user.new_record?
      begin
        Zetto::Services::Session::Registration.new(user, cookies).execute
      rescue ArgumentError
        puts 'Invalid input arguments Zetto::ControllerMethods #create_session_for_user'
        nil
      rescue
        puts 'An error occurred Zetto::ControllerMethods #create_session_for_user'
        nil
      end
    end

  end
end
