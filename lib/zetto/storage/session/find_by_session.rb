module Zetto::Storage::Session

  class FindBySession


    def initialize(session_id)
      @redis = Zetto::Storage::Connect::RedisSingelton.get
      @session_id = session_id
    end

    def execute
      begin
        key = "session:" + @session_id.to_s
        data = {}
        data = @redis.hgetall(key)
        data['time_live_s'] = @redis.ttl(key)
        data["session_id"] = @session_id.to_s
        return Zetto::Storage::Session::Data::Response.new(data)
      rescue Exception => e
        puts e.message
        puts 'An error occurred Zetto::Storage::Session::FindBySession'
        nil
      end
    end

  end

end