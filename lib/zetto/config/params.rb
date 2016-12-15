module Zetto
  module Config

    module Params

      @user_class = ''
      class << self
        attr_accessor :redis_connect, :session_length, :session_time_min

        def set_params
          yield self
        end

        def user_class
          begin
            @user_class.constantize
          rescue Exception => e
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




