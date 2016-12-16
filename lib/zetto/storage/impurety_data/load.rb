module Zetto
  module Storage
    module ImpuretyData

      autoload :Generate, "zetto/storage/impurety_data/generate"
      autoload :Restore, "zetto/storage/impurety_data/restore"
      autoload :Save, "zetto/storage/impurety_data/save"

      module Data
        autoload :Response, "zetto/storage/impurety_data/data/response"
      end

    end
  end
end



