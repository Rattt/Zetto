module Zetto
  module Services
    module Cookie

      class FindUserId

        def initialize(cookies)
          unless cookies.class.to_s == "ActionDispatch::Cookies::CookieJar"
            raise ArgumentError.new('To save session cookies needed, object of ActionDispatch::Cookies::CookieJar')
          end

          @cookies = cookies
        end

        def execute
          token = get_token_from_cookies
          if token.present?
            get_user_id_from_db(token)
          end
        end

        private

        def get_token_from_cookies
          @cookies[:rembo]
        end

        def get_user_id_from_db(token)

        end


      end
    end
  end
end