module Zetto
  module Services
    module Cookie

      class SaveSession
        include Zetto::Services::Cookie::Modules::Common

        def initialize(session, cookies)
          unless session.class == Zetto::Models::Session
            raise ArgumentError.new('Isn\'t an object of Zetto::Models::Session')
          end
          unless cookies.class.to_s == "ActionDispatch::Cookies::CookieJar"
            raise ArgumentError.new('To save session cookies needed, object of ActionDispatch::Cookies::CookieJar')
          end
          @session = session
          @cookies = cookies
        end

        def execute
          data = get_common_data_for_session
          hash_step = data[:hash_step]
          common_hash = data[:common_hash]
          ciphered_common_hash = get_ciphered_common_hash(@session, common_hash)
          value_of_cookie = get_mix_hashes(@session.session_id, ciphered_common_hash, hash_step)
          @cookies[:rembo] = value_of_cookie
          value_of_cookie
        end

        private

        def get_mix_hashes(my_hash, ciphered_common_hash, step)
          step += 1
          my_hash_length = my_hash.length
          ciphered_common_hash_length = ciphered_common_hash.length
          str_length = my_hash_length + ciphered_common_hash_length

          my_hash_array = Array.new(my_hash_length * step)
          my_hash_length.times do |i|
            key = (i+1) * step -1
            my_hash_array[key] = my_hash[i]
          end
          my_hash_array

          ciphered_common_hash_array = Array.new(str_length)
          i= 0
          ciphered_common_hash_key = 0
          loop do
            i += 1 if i % step == 0
            ciphered_common_hash_array[i] = ciphered_common_hash[ciphered_common_hash_key]
            i += 1
            ciphered_common_hash_key += 1
            break if ciphered_common_hash_length == ciphered_common_hash_key
          end
          ciphered_common_hash_array.delete_at(0)


          leng_of_two_array = my_hash_array.length + ciphered_common_hash_array.length
          my_hash_array[leng_of_two_array] = nil
          ciphered_common_hash_array[leng_of_two_array] = nil
          common_array = Array.new(leng_of_two_array)
          leng_of_two_array.times do |i|
            common_array[i] = my_hash_array[i].to_s + ciphered_common_hash_array[i].to_s
          end
          common_array.join
        end

      end

    end
  end
end