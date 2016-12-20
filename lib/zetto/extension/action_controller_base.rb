module Zetto::Extension::ActionControllerBase
  extend ActiveSupport::Concern
  require "zetto/config/params"

  require "zetto/storage/common/load"
  require "zetto/storage/connect/load"
  require "zetto/storage/impurety_data/load"
  require "zetto/storage/session/load"

  require "zetto/services/encryption/load"
  require "zetto/services/cookie/load"
  require "zetto/services/session/load"
  require "zetto/services/authentication/load"


  included do

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
        hashed_password = Zetto::Services::Encryption::PasswordHashing.new(password).execute
        user = Zetto::Services::Authentication::FindUser.new(class_name, name, hashed_password).execute
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
