module Zetto
  module Storage
    module Connect

    require "redis_singelton"

      module RedisSingelton
        @redis = Redis.new(:password => "3443555")
        class << self
          def self.get
            @redis
          end
        end
      end

    end
  end
end
