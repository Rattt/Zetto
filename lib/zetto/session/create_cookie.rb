module Zetto
  module Session

    class CreateCookie

      def initialize(session)
        unless session.class == Zetto::Models::Session
          raise ArgumentError.new('Isn\'t an object of Zetto::Models::Session')
        end
        @session = session
      end

      def create
        data = get_common_hash.split('.')
        unless data.length != 2 || !(data[0].instance_of? Fixnum)
          raise ArgumentError.new('Incorrect common hash data')
        end
        hash_step = data[0].to_i
        common_hash = data[1]
        ciphered_common_hash = get_ciphered_common_hash(common_hash)
        value_of_cookie = get_mix_hashes(@session.session_id, ciphered_common_hash, hash_step)

        if defined? cookies
          cookies[:rembo] = value_of_cookie
        end
        #TODO Здесь добавлю метод, который сохраняет значение в кукис
        value_of_cookie
      end

      private

      def get_common_hash
        path_to_common_hash = File.expand_path(File.dirname(__FILE__))
        File.read(path_to_common_hash.to_s+'/ssessions_common_hash')
      end

      def get_ciphered_common_hash(common_hash)
        case @session.algorithm
          when 'md5'
            Digest::MD5.hexdigest common_hash
          when 'sha1'
            Digest::SHA1.hexdigest common_hash
          else
            Digest::SHA1.hexdigest common_hash
        end
      end

      def get_mix_hashes(my_hash, ciphered_common_hash, step)
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