module Zetto
  module Config

    module Params

      @user_class_name     = 'email'
      @user_class_password = 'password'
      
      @redis_connect = {:password => "3443555", "db" => 1}

      @session_length = 9

      @session_time_min = 30

      @session_time_restart_min = 5

      class << self
        attr_accessor :redis_connect, :session_length, :session_time_min, :session_time_restart_min,
                      :user_class_name, :user_class_password

        def set_params
          yield self
        end

        def user_class
          begin
            @user_class.constantize
          rescue Exception => e
            puts 'Invalid input arguments, unknown target class'
            nil
          end
        end

        def user_class=(user)
          @user_class = user
        end

      end
    end

  end
end




