module Zetto
  module Storage
    module Connect

    require "redis"

      module RedisSingelton
        @redis = Redis.new(:password => "3443555")
        class << self
          def get
            @redis
          end
        end
      end

    end
  end
end
