module Test
  module Emulators

    class Request < Hash

      attr_reader :user_agent ,:remote_ip

      def initialize()
        @user_agent       = 'Google'
        @remote_ip        = '11:11:11'

        self['user_agent'] = 'Google'
        self['remote_ip']  = '11:11:11'
      end

    end

  end
end