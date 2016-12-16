module Zetto::Storage::ImpuretyData

  class Restore

    def execute(token_data_str)
      begin
        token_data_hash = JSON.parse(token_data_str)
        key_of_impurity_hash = token_data_hash.keys[0]
        redis = Zetto::Storage::Connect::RedisSingelton.get
        data = JSON.parse(redis.get('impurity_hash_data:' + key_of_impurity_hash.to_s))
        data['token'] = token_data_hash[key_of_impurity_hash]
        data
      rescue
        puts 'An error occurred Zetto::Storage::ImpuretyData::Restore'
        nil
      end
    end

  end

end