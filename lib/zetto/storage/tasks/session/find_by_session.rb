module Zetto::Storage::Tasks::Session

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
        data["session_id"] = @session_id.to_s
        return Zetto::Storage::Tasks::Session::Data::Response.new(data)
      rescue
        puts 'An error occurred Zetto::Storage::Tasks::Session::FindBySession'
        nil
      end
    end

  end

end