module Zetto
  module Services
    module Cookie
      module Modules
        module Common

          def get_common_data_for_session
            path_to_common_hash = File.expand_path(File.dirname(__FILE__))
            arr = File.read(path_to_common_hash.to_s+'/common_hash').split('.')
            unless arr.length != 2 || (arr[0].to_i.instance_of? Fixnum)
              raise ArgumentError.new('Incorrect common hash data')
            end
            {hash_step: arr[0].to_i, common_hash: arr[1]}
          end

          def get_ciphered_common_hash(sessionObj, common_hash)
            Zetto::Models::Session.algorithms.keys.include?(sessionObj.algorithm) ? "Digest::#{sessionObj.algorithm}".constantize.hexdigest common_hash :  Digest::SHA1.hexdigest common_hash
          end

        end
      end
    end
  end
end
