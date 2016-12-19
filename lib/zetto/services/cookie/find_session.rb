module Zetto::Services::Cookie

  class FindSession
    include Zetto::Services::Cookie::Modules::Crypto

    def initialize(cookies)
      unless cookies.class.to_s == "ActionDispatch::Cookies::CookieJar"
        raise ArgumentError.new('To save session cookies needed, object of ActionDispatch::Cookies::CookieJar')
      end
      @cookies = cookies
    end

    def execute
      begin
        token_data = get_token_from_cookies
        if token_data.present?
          get_session_from_db(token_data)
        end
      rescue
        puts 'An error occurred Zetto::Services::Cookie::FindSession'
        nil
      end
    end

    private

    def get_token_from_cookies
      @cookies[:rembo]
    end

    def get_session_from_db(token_data)
      data_session = Zetto::Storage::ImpuretyData::Restore.new.execute(token_data)

      data_token = get_data_of_token(data_session['token'], data_session['hash_step'])
      session = Zetto::Storage::Session::FindBySession.new(data_token[:session_id]).execute()

      if secret_hash_correct?(session, data_session['impurity_hash'], data_token[:ciphered_impurity_hash])
        session
      end

      session
    end

    def secret_hash_correct?(sessionObj, impurity_hash, ciphered_impurity_hash)
      return false if sessionObj.nil?
      get_ciphered_impurity_hash(sessionObj, impurity_hash) == ciphered_impurity_hash
    end

  end

end