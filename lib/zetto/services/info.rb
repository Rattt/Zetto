module Zetto::Modules

  module Info
    require 'colorize'

      class << self
        def error_message(message, error = nil)
          $stderr.puts message.colorize(:red)
        end

        def info(message)
          puts message.colorize(:blue)
        end

        def result(arr)
          puts I18n.t('result.title').colorize(:green)
          puts arr.to_s.colorize(:green)
        end
      end

  end

end