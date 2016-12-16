module Zetto::Services::Cookie

  class SaveSession
    include Zetto::Services::Cookie::Modules::Crypto

    def initialize(session, cookies)

      unless session.class.to_s == "Zetto::Storage::Tasks::Session::Data::Response"
        raise ArgumentError.new('Isn\'t an object of Zetto::Storage::Tasks::Session::Data::Response')
      end
      unless cookies.class.to_s == "ActionDispatch::Cookies::CookieJar"
        raise ArgumentError.new('To save session cookies needed, object of ActionDispatch::Cookies::CookieJar')
      end
      @session = session
      @cookies = cookies
    end

    def execute
      begin
        data = Zetto::Storage::Tasks::ImpuretyData::Generate.new.execute
        data[:ciphered_impurity_hash] = get_ciphered_impurity_hash(@session, data['impurity_hash'])
        mixed_hash = get_mix_hashes(@session.session_id, data[:ciphered_impurity_hash], data['hash_step'])
        @cookies[:rembo] = {data['key'] => mixed_hash}.to_json
        Zetto::Storage::Tasks::ImpuretyData::Save.new.execute(data)
        mixed_hash
      rescue
        puts 'An error occurred Zetto::Services::Cookie::SaveSession'
        nil
      end
    end

  end

end