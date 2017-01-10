

module Zetto::Extension::ActiveRecord
  extend ActiveSupport::Concern
  require "zetto/modules/load"
  require "zetto/services/encryption/load"

  included do

    protected

    def password_confirmed
      begin
        password_field  = Zetto::Config::Params.user_class_password
        password_value  = send(password_field).to_s
        errors.add(password_field.intern, I18n.t('validate.password_confirm')) unless password_value == password_confirmation

        password_confirmation
      rescue Exception => e
        Zetto::Services::Info.error_message I18n.t('exseptions.undefined_field', field: password_field), e
      end
    end

    validate.undefined_field

    def password_encryption
      begin
        password_field  = Zetto::Config::Params.user_class_password
        password_value  = send(password_field)
        hashed_password = Zetto::Services::Encryption::PasswordHashing.new(password_value).execute
        send(password_field+'=', hashed_password)
      rescue Exception => e
        Zetto::Services::Info.error_message I18n.t('exseptions.undefined_field', field: password_field), e
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
      validates      Zetto::Config::Params.user_class_name.intern, uniqueness:true
      validates      Zetto::Config::Params.user_class_password.intern, presence: true,
                     length: { minimum: Zetto::Config::Params.user_class_password_length_larger }

      validate      :password_confirmed
      before_save   :password_encryption
    end

  end

end


