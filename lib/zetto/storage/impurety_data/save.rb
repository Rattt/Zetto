module Zetto::Storage::ImpuretyData

  class Save

    def execute(data)
      unless data.class.to_s == "Zetto::Storage::ImpuretyData::Data::Response"
        raise ArgumentError.new(I18n.t('exseptions.isnt_object', class_name: 'Zetto::Storage::ImpuretyData::Data::Response'))
      end
      save_data = {}
      key = data['key']
      save_data['hash_step'] = data['hash_step']
      save_data['impurity_hash'] = data['impurity_hash']

      redis = Zetto::Storage::Connect::RedisSingelton.get
      impurity_hash_key = 'impurity_hash_data:' + key.to_s
      redis.set(impurity_hash_key, save_data.to_json)
      redis.expire(impurity_hash_key, Zetto::Config::Params.session_time_min * 60)
    rescue Exception => e
      Zetto::Services::Info.error_message I18n.t('exseptions.unknown_error', argument: 'Zetto::Storage::ImpuretyData::Save', current_method: __method__), e
      nil
    end

  end

end