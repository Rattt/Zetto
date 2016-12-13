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
          end
        end

        def get_data_of_token(token, step)
          token_length      = token.length
          count_of_session  = Zetto::Models::Session::SESSION_LENGTH
          not_crowded_steps = (token_length - count_of_session) / step

          ciphered_common_hash_arr = Array.new
          session_id_arr           = Array.new

          frequency = 0
          arr = token.chars
          arr.length.times do |i|
            if step == frequency &&
               not_crowded_steps > 0 &&
               count_of_session > 0
              session_id_arr << arr[i]
              not_crowded_steps -= 1
              count_of_session -= 1
              frequency = 0
            else
              ciphered_common_hash_arr << arr[i]
              frequency += 1
            end
          end

          if count_of_session > 0
            session_id_arr += ciphered_common_hash_arr.last(count_of_session)
            ciphered_common_hash_arr = ciphered_common_hash_arr[0..ciphered_common_hash_arr.length - 1 - count_of_session]
          end

          ciphered_common_hash = ciphered_common_hash_arr.join("")
          session_id = session_id_arr.join("")

          {session_id: session_id, ciphered_common_hash: ciphered_common_hash}
        end

        def secret_hash_correct?(sessionObj, common_hash, ciphered_common_hash)
          return false if sessionObj.nil?
          get_ciphered_common_hash(sessionObj, common_hash) == ciphered_common_hash
        end

      end
    end
  end
end