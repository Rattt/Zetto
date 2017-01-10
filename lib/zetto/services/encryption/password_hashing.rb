module Zetto::Services::Encryption

  class PasswordHashing
    include Zetto::Modules::Crypto

    def initialize(password)
      @password = password
    end

    def execute
      generate_hashing(Zetto::Config::Params.user_class_password_crypto, @password)
    rescue Exception => e
      Zetto::Services::Info.error_message I18n.t('exseptions.unknown_error', argument: 'Zetto::Services::Encryption::PasswordHashing', current_method: __method__), e
      nil
    end

  end

end