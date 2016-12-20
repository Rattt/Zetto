module Zetto::Services::Encryption

  class PasswordHashing
    include Zetto::Modules::Crypto

    def initialize(password)
      @password = password
    end

    def execute
      begin
        generate_hashing(Zetto::Config::Params.user_class_password_crypto, @password)
      rescue Exception => e
        puts e.message
        puts 'An error occurred Zetto::Services::Encryption::PasswordHashing'
        nil
      end
    end

  end

end