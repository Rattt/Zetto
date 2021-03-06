module Zetto::Services::Cookie

  class SaveSession
    include Zetto::Modules::Crypto

    def initialize(session, cookies)

      unless session.class.to_s == "Zetto::Storage::Session::Data::Response"
        raise ArgumentError.new(I18n.t('exseptions.isnt_object', class_name: 'Zetto::Storage::Session::Data::Response'))
      end
      unless cookies.class.to_s == "ActionDispatch::Cookies::CookieJar"
        raise ArgumentError.new(I18n.t('exseptions.save_session_cookies'))
      end
      @session = session
      @cookies = cookies
    end

    def execute

      impuretyData = Zetto::Storage::ImpuretyData::Generate.new.execute

      ciphered_impurity_hash = generate_hashing(@session.algorithm, impuretyData['impurity_hash'])
      mixed_hash = get_mix_hashes(@session.session_id, ciphered_impurity_hash, impuretyData['hash_step'])

      value = save_cookie(impuretyData, mixed_hash)
      Zetto::Storage::ImpuretyData::Save.new.execute(impuretyData)

      value
    rescue Exception => e
      Zetto::Services::Info.error_message I18n.t('exseptions.unknown_error', argument: 'Zetto::Services::Cookie::SaveSession', current_method: __method__), e
      nil

    end

    private

    def save_cookie(impuretyData, mixed_hash)
      @cookies[:rembo] = {impuretyData['key'] => mixed_hash}.to_json
    end

  end

end