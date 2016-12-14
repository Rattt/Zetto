module Zetto
  module Storage
    module Keep
      module ImpuretyData

        class Save

          def execute(data)
            begin
              redis = Zetto::Storage::Connect::RedisSingelton.get
              impurity_hash_key = 'impurity_hash_data:' + data['key'].to_s
              redis.set(impurity_hash_key, data.to_json)
              redis.expire(impurity_hash_key, 3600)
            rescue
              puts 'An error occurred Zetto::Storage::ImpuretyData::Save'
              nil
            end
          end

        end

      end
    end
  end
end