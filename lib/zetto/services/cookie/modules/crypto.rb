module Zetto::Services::Cookie
  module Modules
    module Crypto

      private

      def get_ciphered_impurity_hash(session_obj, impurity_hash)
        Zetto::Config::Params::CRYPTO_ALGORITHMS.include?(session_obj.algorithm) ?
            "Digest::#{session_obj.algorithm}".constantize.hexdigest(impurity_hash) : Digest::SHA1.hexdigest(impurity_hash)
      end

      def get_data_of_token(token, step)
        token_length = token.length
        count_of_session = Zetto::Config::Params.session_length
        not_crowded_steps = (token_length - count_of_session) / step

        ciphered_impurity_hash_arr = Array.new
        session_id_arr = Array.new

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
            ciphered_impurity_hash_arr << arr[i]
            frequency += 1
          end
        end

        if count_of_session > 0
          session_id_arr += ciphered_impurity_hash_arr.last(count_of_session)
          ciphered_impurity_hash_arr = ciphered_impurity_hash_arr[0..ciphered_impurity_hash_arr.length - 1 - count_of_session]
        end

        ciphered_impurity_hash = ciphered_impurity_hash_arr.join("")
        session_id = session_id_arr.join("")

        {session_id: session_id, ciphered_impurity_hash: ciphered_impurity_hash}
      end

      def get_mix_hashes(my_hash, ciphered_impurity_hash, step)
        step += 1
        my_hash_length = my_hash.length
        ciphered_impurity_hash_length = ciphered_impurity_hash.length
        str_length = my_hash_length + ciphered_impurity_hash_length

        my_hash_array = Array.new(my_hash_length * step)
        my_hash_length.times do |i|
          key = (i+1) * step -1
          my_hash_array[key] = my_hash[i]
        end
        my_hash_array

        ciphered_impurity_hash_array = Array.new(str_length)
        i= 0
        ciphered_impurity_hash_key = 0
        loop do
          i += 1 if i % step == 0
          ciphered_impurity_hash_array[i] = ciphered_impurity_hash[ciphered_impurity_hash_key]
          i += 1
          ciphered_impurity_hash_key += 1
          break if ciphered_impurity_hash_length == ciphered_impurity_hash_key
        end
        ciphered_impurity_hash_array.delete_at(0)


        leng_of_two_array = my_hash_array.length + ciphered_impurity_hash_array.length
        my_hash_array[leng_of_two_array] = nil
        ciphered_impurity_hash_array[leng_of_two_array] = nil
        common_array = Array.new(leng_of_two_array)
        leng_of_two_array.times do |i|
          common_array[i] = my_hash_array[i].to_s + ciphered_impurity_hash_array[i].to_s
        end
        common_array.join
      end

    end
  end
end
