module Zetto::Extension::ActiveRecord
  extend ActiveSupport::Concern

  included do

    def correct_password
      begin
        password_field = Zetto::Config::Params.user_class_password
        password_length = Zetto::Config::Params.user_class_password_length_larger
        errors.add(password_field.intern, "Password is too short") if (send(password_field)).to_s.length < password_length
      rescue
      end
    end

    def password_encryption

    end

  end

  class_methods do

    def zetto(method)
      method_name = 'zetto_' + method.to_s
      self.send(method_name) if 'zetto_authentication' == method_name
    end

    private

    def zetto_authentication
      validate    :correct_password,    on: :create
      before_save :password_encryption, on: :create
    end

  end


end


