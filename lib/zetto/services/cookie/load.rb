module Zetto
  module Services
    module Cookie

      autoload :FindSession, "zetto/services/cookie/find_session"
      autoload :SaveSession, "zetto/services/cookie/save_session"

      module Modules
        autoload :Crypto, "zetto/services/cookie/modules/crypto"
      end

    end
  end
end


