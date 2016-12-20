module Zetto::Services::Encryption

  class PasswordHashing

    def initialize(password)
      @password = password
    end

    def execute
      begin
        Zetto::Config::Params::CRYPTO_ALGORITHMS.include?(Zetto::Config::Params.user_class_password_crypto) ?
            "Digest::#{Zetto::Config::Params.user_class_password_crypto}".constantize.hexdigest(@password) : Digest::SHA1.hexdigest(@password)
      rescue Exception => e
        puts e.message
        puts 'An error occurred Zetto::Services::Encryption::PasswordHashing'
        nil
      end
    end

  end

end