module Zetto::Services

  module Info


      class << self

        def error_message(message, error = nil)
          if !error.nil? && error.is_a?(StandardError)
            if Zetto::Config::Params.log
              logger = Zetto::Services::ZettoLogger.instance
              logger.fatal { I18n.t('log.error') + "\n" + message + "\n" + error.message }
            end
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