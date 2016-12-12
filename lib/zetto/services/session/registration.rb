module Zetto
  module Services
    module Session

      class Registration

        ALGORITHMS = ['sha1', 'md5']

        def initialize(user, cookies)
          unless user.class == Zetto::Config::Params.user_class
            raise ArgumentError.new('Isn\'t an object of Zetto::Config::Params.user_class')
          end
          unless cookies.class.to_s == "ActionDispatch::Cookies::CookieJar"
            raise ArgumentError.new('To save session cookies needed, object of ActionDispatch::Cookies::CookieJar')
          end

          @user = user
          @cookies = cookies
        end

        def execute
          if session = save_session_db
            create_cookie?(session)
          end
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
            session = Zetto::Models::Session.new(new_session_data)

            if (session.valid? ||
                {:user_id=>["has already been taken"]} == session.errors.messages)
              remove_exist_record_if_exist(@user.id)
              return Zetto::Models::Session.create(new_session_data)
            end

          end
          nil
        end

        def remove_exist_record_if_exist(id)
          if session = Zetto::Models::Session.find_by(user_id: id)
            session.destroy
          end
        end

        def create_cookie?(session)
          !(Zetto::Services::Cookie::Create.new(session, @cookies).execute.nil?)
        end

      end
    end
  end
end

