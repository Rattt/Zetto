module Zetto::Storage::ImpuretyData

  class Save

    def execute(data)
      begin
        save_data = {}
        key = data['key']
        save_data['hash_step'] = data['hash_step']
        save_data['impurity_hash'] = data['impurity_hash']

        if save_data.values.include?(nil) || key == nil
          raise ArgumentError.new('Incorrect data for storage shunt hash')
        end

        redis = Zetto::Storage::Connect::RedisSingelton.get
        impurity_hash_key = 'impurity_hash_data:' + key.to_s
        redis.set(impurity_hash_key, save_data.to_json)
        redis.expire(impurity_hash_key, Zetto::Config::Params.session_time_min * 60)
      rescue
        puts 'An error occurred Zetto::Storage::ImpuretyData::Save'
        nil
      end
    end

  end

end