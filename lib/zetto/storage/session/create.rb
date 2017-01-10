module Zetto::Storage::Session

  class Create

    def initialize(user, user_agent, remote_ip)
      @redis = Zetto::Storage::Connect::RedisSingelton.get
      @user = user
      @user_agent = user_agent
      @remote_ip = remote_ip
    end

    def execute
      begin
        new_session_data = nil
        5.times do
          new_session_data = {}
          new_session_data["user_id"]    = @user.id
          new_session_data["session_id"] = genrate_session_id
          new_session_data["algorithm"]  = generate_random_algorithm
          new_session_data["class_name"] = @user.class.to_s
          new_session_data["user_agent"] = Digest::MD5.hexdigest(@user_agent)
          new_session_data["remote_ip"]  = @remote_ip

          if validate_session_id_uniq?(new_session_data["session_id"])
            remove_old_hash!
            return save(new_session_data)
          end
        end
        nil
      rescue Exception => e
        Zetto::Services::Info.error_message I18n.t('exseptions.unknown_error', argument: 'Zetto::Storage::Session::Create', current_method: __method__), e
        nil
      end
    end

    private

    def validate_session_id_uniq?(session_id)
      @redis.zscore("sessions", session_id) ? false : true
    end

    def save(new_session_data)
      time_death = Zetto::Config::Params.session_time_min * 60
      time_end = Time.now.to_i + time_death

      @redis.zadd("sessions", time_end, new_session_data["session_id"])

      key = "session:" + new_session_data["session_id"].to_s
      @redis.hset(key, 'user_id', new_session_data["user_id"])
      @redis.hset(key, 'algorithm', new_session_data["algorithm"])
      @redis.hset(key, 'class_name', new_session_data["class_name"])
      @redis.hset(key, 'user_agent', new_session_data["user_agent"])
      @redis.hset(key, 'remote_ip',  new_session_data["remote_ip"]) if Zetto::Config::Params.check_ip == true
      @redis.expire(key, time_death)
      new_session_data["time_live_s"] = time_death
      Zetto::Storage::Session::Data::Response.new(new_session_data)
    end

    def genrate_session_id
      SecureRandom.hex(9)[0..8]
    end

    def generate_random_algorithm
      Zetto::Config::Params::CRYPTO_ALGORITHMS.sample
    end

    def remove_old_hash!
      @redis.zremrangebyscore('sessions', 0, Time.now.to_i)
    end

  end

end