module Test
  module Emulators

    class Cookie < Hash
      @@rembo = ''

      def class
        'ActionDispatch::Cookies::CookieJar'
      end

      def initialize
        self[:rembo]  = @@rembo
      end

      def self.set_cokie_rembo(value)
        @@rembo = value
      end

    end

  end
end