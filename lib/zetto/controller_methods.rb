module Zetto
  module ControllerMethods

    def current_user
      begin
        Zetto::Services::Session::GetUser.new(cookies).execute
      rescue ArgumentError => e
        puts e.message
        puts 'Invalid input arguments Zetto::ControllerMethods #current_user'
        nil
      rescue
        puts 'An error occurred Zetto::ControllerMethods #current_user'
        nil
      end
    end

    def authentication(class_name, name, password)
      begin
        user = Zetto::Services::Authentication::FindUser.new(class_name, name, password).execute
        return nil if user.nil?
        return nil if user.new_record?
        Zetto::Services::Session::Registration.new(user, cookies).execute
      rescue ArgumentError => e
        puts e.message
        puts 'Invalid input arguments Zetto::ControllerMethods #authentication'
        nil
      rescue Exception => e
        puts e.message
        puts 'An error occurred Zetto::ControllerMethods #authentication'
        nil
      end
    end

    def logout
      @cookies[:rembo] = nil
    end

  end
end
