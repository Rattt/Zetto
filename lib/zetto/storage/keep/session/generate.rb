module Zetto
  module Storage
    module Keep
      module Session

        class Generate

          def initialize(user)
            @user = user
          end

          def execute
            begin

            rescue
              puts 'An error occurred Zetto::Storage::Session::Generate'
              nil
            end
          end

          private


        end

      end
    end
  end
end