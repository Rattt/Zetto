module Zetto
  module Storage
    module Keep
      module ImpuretyData

        class Generate

          def execute
            begin
              data = {}
              data['hash_step'] = generate_step
              data['impurity_hash'] = generate_hash
              data['key'] = generate_key

              data
            rescue
              puts 'An error occurred Zetto::Storage::ImpuretyData::Generate'
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
            rand(10000)
          end

        end

      end
    end
  end
end