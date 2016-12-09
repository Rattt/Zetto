module Zetto
  module Seance

    class SessionRegistration

      ALGORITHMS = ['sha1', 'md5']

      def initialize(user)
        @user = user
      end

      def execute
        save_session_db
      end

      private

      def genrate_session_id
        (0...9).map { (65 + rand(26)).chr }.join
      end

      def get_random_algorithm
        ALGORITHMS.sample
      end

      def save_session_db
        5.times do
          new_session_data = {}
          new_session_data[:user_id] = @user.id
          new_session_data[:session_id] = genrate_session_id
          new_session_data[:algorithm] = get_random_algorithm
          sessionObj = Zetto::Models::Session.new(new_session_data)
          if (sessionObj.valid?)
            Zetto::Models::Session.create(new_session_data)
            break
          end
        end
      end

    end

  end
end

