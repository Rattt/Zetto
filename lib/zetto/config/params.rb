module Zetto
  module Config

    module Params

      CRYPTO_ALGORITHMS = ['MD5', 'SHA1', 'RMD160', 'SHA256', 'SHA384', 'SHA512']

      @user_classes = ['User']

      @user_class_name                   = 'email'
      @user_class_password               = 'password'
      @user_class_password_length_larger = 6
      @user_class_password_crypto        = 'SHA1'
      @check_ip                          = false
      @log                               = false
      
      @redis_connect = {:password => "3443555", "db" => 1}

      @session_length = 9
      @session_time_min = 30
      @session_time_restart_min = 5

      class << self
        attr_accessor :redis_connect, :session_length, :session_time_min, :session_time_restart_min,
                      :user_class_name, :user_class_password, :user_class_password_length_larger, :check_ip, :log

        attr_reader :user_class_password_crypto

        def set_params
          yield self
        end

        def user_class_password_crypto=(value)
          value = value.to_s.upcase
          unless self::CRYPTO_ALGORITHMS.include?(value)
            raise ArgumentError.new("Unknown algorithm \"#{value}\"")
          end
          @user_class_password_crypto = value
        end

        def user_classes=(arr)
          @user_classes = arr.map{ |class_name| class_name.to_s.capitalize  }
        end

        def user_class(class_str)
          begin
            unless @user_classes.include?(class_str)
              raise ArgumentError.new("Unknown target class \"#{class_str}\"")
            end
            class_str.constantize
          rescue Exception => e
            puts e.message
            nil
          end
        end

      end
    end

  end
end




