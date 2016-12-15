module Zetto::Storage::Tasks::ImpuretyData

  class Generate

    def initialize
      @redis = Zetto::Storage::Connect::RedisSingelton.get
    end

    def execute
      begin
        remove_old_hash!
        data = {}
        data['hash_step'] = generate_step
        data['impurity_hash'] = generate_hash
        data['key'] = generate_key

        data
      rescue
        puts 'An error occurred Zetto::Storage::Tasks::ImpuretyData::Generate'
        nil
      end
    end

    private

    def generate_step
      rand(6) + 1
    end

    def generate_hash
      SecureRandom.urlsafe_base64(rand(10)+10)
    end

    def generate_key
      result = nil
      5.times do
        key = rand(36**12).to_s(36)

        time_end = Time.now.to_i + Zetto::Config::Params.session_time_min * 60

        if (@redis.zadd('impurity_hash_keys_sort_by_date', time_end, key))
          result = key
          break
        end
      end
      result
    end

    def remove_old_hash!
      @redis.zremrangebyscore('impurity_hash_keys_sort_by_date', 0, Time.now.to_i)
    end

  end


end