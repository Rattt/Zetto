module Zetto
  module Config
    class Params
      @@user_class = ''

      def self.user_class
        begin
          @@user_class.constantize
        rescue Exception => e
          nil
        end
      end

      def self.user_class=(user)
        @@user_class = user
      end

    end
  end
end