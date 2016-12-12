module Zetto
  module Services
    module Cookie

      class FindSession
        include Zetto::Services::Cookie::Modules::Common

        def initialize(cookies)
          unless cookies.class.to_s == "ActionDispatch::Cookies::CookieJar"
            raise ArgumentError.new('To save session cookies needed, object of ActionDispatch::Cookies::CookieJar')
          end

          @cookies = cookies
        end

        def execute
          token = get_token_from_cookies
          if token.present?
            get_session_from_db(token)
          end
        end

        private

        def get_token_from_cookies
          @cookies[:rembo]
        end

        def get_session_from_db(token)
          data = get_common_data_for_session
          step = data[:hash_step]
          common_hash = data[:common_hash]
          data = get_data_of_token(token, step)
          session = Zetto::Models::Session.find_by(session_id: data[:session_id])
          if secret_hash_correct?(session, common_hash, data[:ciphered_common_hash])
            session
          else
            nil
          end
        end

        def get_data_of_token(token, step)
          # TODO Будут сбои при большом шаге, поправить
          count_of_session = 9
          arr = token.chars
          ciphered_common_hash = Array.new
          session_id = Array.new
          j = 0
          arr.length.times do |i|
            if step == j
              if count_of_session > 0
                session_id << arr[i]
                j = 0
              else
                ciphered_common_hash << arr[i]
              end
              count_of_session -= 1
            else
              ciphered_common_hash << arr[i]
              j += 1
            end
          end
          {session_id: session_id.join(""), ciphered_common_hash: ciphered_common_hash.join("")}
        end

        def secret_hash_correct?(sessionObj, common_hash, ciphered_common_hash)
          return false if sessionObj.nil?
          get_ciphered_common_hash(sessionObj, common_hash) == ciphered_common_hash
        end

      end
    end
  end
end