module Zetto::Services::Cookie

  class FindSession
    include Zetto::Modules::Crypto

    def initialize(cookies)
      unless cookies.class.to_s == "ActionDispatch::Cookies::CookieJar"
        raise ArgumentError.new(I18n.t('exseptions.need_cookie'))
      end
      @cookies = cookies
    end

    def execute
      token_data = get_token_from_cookies
      if token_data.present?
        get_session_from_db(token_data)
      end
    rescue Exception => e
      Zetto::Services::Info.error_message I18n.t('exseptions.unknown_error', argument: 'Zetto::Services::Cookie::FindSession', current_method: __method__), e
      nil
    end

    private

    def get_token_from_cookies
      @cookies[:rembo]
    end

    def get_session_from_db(token_data)
      data_session = Zetto::Storage::ImpuretyData::Restore.new.execute(token_data)
      return nil if data_session.nil?

      data_token = get_data_of_token(data_session['token'], data_session['hash_step'], Zetto::Config::Params.session_length)
      session = Zetto::Storage::Session::FindBySession.new(data_token[:session_id]).execute

      if secret_hash_correct?(session, data_session['impurity_hash'], data_token[:ciphered_hash])
        session
      end

      session
    end

    def secret_hash_correct?(session, impurity_hash, ciphered_hash)
      return false if session.nil?
      generate_hashing(session.algorithm, impurity_hash) == ciphered_hash
    end

  end

end