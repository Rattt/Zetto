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
      
      @redis_connect = {:password => "", "db" => 1}

      @session_length = 9
      @session_time_min = 30
      @session_time_restart_min = 5

      class << self

        def self.attr_writer_with_type(type, *args)
          args.each do |arg|
            self.send(:define_method, "#{arg}=".intern) do |value|
              unless value.class.to_s == type
                raise ArgumentError.new(I18n.t('exseptions.not_specified_type', arg: arg, type: type, class_name: value.class.to_s))
              end
              instance_variable_set("@#{arg}", value)
            end
          end
        end

        attr_writer_with_type 'Boolean', :check_ip, :log
        attr_writer_with_type 'Fixnum',  :session_time_restart_min, :session_time_min, :session_length, :user_class_password_length_larger
        attr_writer_with_type 'Hash',    :redis_connect
        attr_writer_with_type 'String',  :user_class_name, :user_class_password

        attr_reader :user_class_password_crypto, :check_ip, :log, :session_time_restart_min, :session_time_min, :session_length, :user_class_password_length_larger, :redis_connect,
                    :user_class_name, :user_class_password

        def set_params
          yield self
        end

        def user_class_password_crypto=(value)
          value = value.to_s.upcase
          unless self::CRYPTO_ALGORITHMS.include?(value)
            raise ArgumentError.new(I18n.t('exseptions.unknown_algorithm', algorithm: value.to_s ))
          end
          @user_class_password_crypto = value
        end

        def user_classes=(arr)
          @user_classes = arr.map{ |class_name| class_name.to_s.capitalize  }
        end

        def user_class(class_str)
          begin
            unless @user_classes.include?(class_str)
              raise ArgumentError.new(I18n.t('exseptions.unknown_target_class', class_name: class_str.to_s ))
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




