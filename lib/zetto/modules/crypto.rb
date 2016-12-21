module Zetto::Modules
    module Crypto

      private

      def generate_hashing(algorithm, value)
        Zetto::Config::Params::CRYPTO_ALGORITHMS.include?(algorithm) ?
            "Digest::#{algorithm}".constantize.hexdigest(value) : Digest::SHA1.hexdigest(value)
      end

      def get_data_of_token(token, step, count_of_session)

        chars = token.chars
        token_length = chars.length
        not_crowded_steps = (token_length - count_of_session) / step

        ciphered_hash_arr = Array.new
        session_id_arr    = Array.new

        i = 0
        while not_crowded_steps > 0  do
          i.upto(i+step-1)  do |i|
            ciphered_hash_arr << chars[i]
          end
          i += step
          break if not_crowded_steps < 1 || count_of_session < 1
          session_id_arr << chars[i]
          not_crowded_steps -=1
          count_of_session	 -=1
          i +=1
        end
        while i < token_length
          ciphered_hash_arr << chars[i]
          i+=1
        end

        if count_of_session > 0
          session_id_arr += ciphered_hash_arr.last(count_of_session)
          ciphered_hash_arr = ciphered_hash_arr[0..ciphered_hash_arr.length - 1 - count_of_session]
        end

        ciphered_hash = ciphered_hash_arr.join("")
        session_id    = session_id_arr.join("")

        {session_id: session_id, ciphered_hash: ciphered_hash}
      end

      def get_mix_hashes(my_hash, ciphered_hash, step)
        step += 1

        my_hash_length = my_hash.length
        ciphered_hash_length = ciphered_hash.length
        str_length = my_hash_length + ciphered_hash_length

        my_hash_arr = Array.new(my_hash_length * step)

        my_hash_length.times do |i|
          key = (i+1) * step - 1
          my_hash_arr[key] = my_hash[i]
        end

        i = 0
        ciphered_hash_arr = Array.new(str_length)
        ciphered_hash_key = 0

        ciphered_hash_arr_length = ciphered_hash_length + (ciphered_hash_length + ciphered_hash_length )/step
        1.upto(ciphered_hash_arr_length)  do |i|
          next if i % step == 0
          ciphered_hash_arr[i] = ciphered_hash[ciphered_hash_key]
          ciphered_hash_key += 1
        end

        ciphered_hash_arr.delete_at(0)
        leng_of_two_array = my_hash_arr.length + ciphered_hash_arr.length
        my_hash_arr[leng_of_two_array] = nil
        ciphered_hash_arr[leng_of_two_array] = nil
        common_array = Array.new(leng_of_two_array)

        leng_of_two_array.times do |i|
          common_array[i] = my_hash_arr[i] || ciphered_hash_arr[i]
        end
        common_array.join
      end

    end
end
