module Zetto
  module Config

    module Params

      CRYPTO_ALGORITHMS = ['MD5', 'SHA1', 'RMD160', 'SHA256', 'SHA384', 'SHA512']

      @user_classes = ['User']

      @user_class_name     = 'email'
      @user_class_password = 'password'
      @user_class_password_length_larger = 6
      @user_class_password_crypto = 'SHA1'
      @check_ip = false
      
      @redis_connect = {:password => "3443555", "db" => 1}

      @session_length = 9
      @session_time_min = 30
      @session_time_restart_min = 5

      class << self
        attr_accessor :redis_connect, :session_length, :session_time_min, :session_time_restart_min,
                      :user_class_name, :user_class_password, :user_class_password_length_larger,
                      :user_class_password_crypto, :check_ip

        attr_writer   :user_classes

        def set_params
          yield self
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




