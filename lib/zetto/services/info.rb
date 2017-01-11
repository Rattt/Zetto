module Zetto::Modules

  module Info


      class << self

        def error_message(message, error = nil)
          if !error.nil? && error.is_a?(StandardError)

          else
            $stderr.puts message
          end
        end

        def info(message)
          puts message
        end

      end

  end

end