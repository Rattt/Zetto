module Zetto::Storage::ImpuretyData::Data

  class Response < Zetto::Storage::Common::Response

    attr_reader :hash_step,:impurity_hash,:key

    def initialize(data)
      @hash_step        = data["hash_step"]
      @impurity_hash    = data["impurity_hash"]
      @key              = data["key"]

      self['hash_step']     = data["hash_step"]
      self['impurity_hash'] = data["impurity_hash"]
      self['key']           = data["key"]

      deep_freeze
    end

  end

end