module Zetto::Storage::Connect

  require "redis"

  module RedisSingelton

    @redis = Redis.new (Zetto::Config::Params.redis_connect || {}).merge({:driver => :hiredis})
    class << self
      def get
        @redis
      end
    end
  end

end


