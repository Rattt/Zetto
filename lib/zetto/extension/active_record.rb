

module Zetto::Extension::ActiveRecord
  extend ActiveSupport::Concern
  require "zetto/services/encryption/load"


  included do

    protected

    def password_confirmed
      begin
        password_field  = Zetto::Config::Params.user_class_password
        password_value  = send(password_field).to_s
        errors.add(password_field.intern, "Password must be checked attribute password_confirmation") unless password_value == password_confirmation

        password_confirmation
      rescue
        puts "An error occurred, most likely you do not have such a field #{password_field} "
      end
    end

    def password_confirmed
      begin
        password_field  = Zetto::Config::Params.user_class_password
        password_value  = send(password_field)
        hashed_password = Zetto::Services::Encryption::PasswordHashing.new(password_value).execute
        send(password_field+'=', hashed_password)
      rescue
        puts "An error occurred, most likely you do not have such a field #{password_field} "
      end
    end

  end

  class_methods do

    def zetto(method)
      method_name = 'zetto_' + method.to_s
      self.send(method_name) if 'zetto_authentication' == method_name
    end

    protected

    def zetto_authentication
      attr_accessor :password_confirmation
      validates      Zetto::Config::Params.user_class_password.intern, presence: true, uniqueness:true,
                     length: { minimum: Zetto::Config::Params.user_class_password_length_larger }

      validate      :password_confirmed,    on: :create
      before_save   :password_encryption,   on: :create
    end

  end

end


