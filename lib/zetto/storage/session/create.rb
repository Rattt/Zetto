module Zetto::Storage::Session

  class Create

    ALGORITHMS = [ 'MD5', 'SHA1', 'RMD160', 'SHA256', 'SHA384', 'SHA512']

    def initialize(user)
      @redis = Zetto::Storage::Connect::RedisSingelton.get
      @user = user
    end

    def execute
      begin
        new_session_data = nil
        5.times do
          new_session_data = {}
          new_session_data["session_id"] = genrate_session_id
          new_session_data["user_id"]    = @user.id
          new_session_data["algorithm"]  = get_random_algorithm

          if validate_session_id_uniq?(new_session_data["session_id"])
            save_session(new_session_data)

            return Zetto::Storage::Session::Data::Response.new(new_session_data)
          end
        end
        nil
      rescue
        puts 'An error occurred Zetto::Storage::Session::Create'
        nil
      end
    end

    private

    def validate_session_id_uniq?(session_id)
      @redis.zscore("sessions", session_id) ? false : true
    end

    def save_session(new_session_data)
      time_life = Zetto::Config::Params.session_time_min * 60
      time_end = Time.now.to_i + time_life

      @redis.zadd("sessions", time_end, new_session_data["session_id"])
      key = "sessions_user:" + new_session_data["user_id"].to_s

      @redis.set(key, new_session_data["session_id"])
      @redis.expire(key, time_life)

      key = "session:" + new_session_data["session_id"].to_s
      @redis.hset(key, 'user_id', new_session_data["user_id"])
      @redis.hset(key, 'algorithm', new_session_data["algorithm"])
      @redis.expire(key, time_life)
    end

    def genrate_session_id
      SecureRandom.hex(9)[0..8]
    end

    def get_random_algorithm
      ALGORITHMS.sample
    end

    def remove_old_hash!
      @redis.zremrangebyscore('sessions', 0, Time.now.to_i)
    end

  end

end