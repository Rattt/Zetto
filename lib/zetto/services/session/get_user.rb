module Zetto
  module Services
    module Session

      class GetUser

        def initialize(cookies)
          unless cookies.class.to_s == "ActionDispatch::Cookies::CookieJar"
            raise ArgumentError.new('To save session cookies needed, object of ActionDispatch::Cookies::CookieJar')
          end

          @cookies = cookies
        end

        def execute
          find_user_id_by_cookie
        end

        private

        def find_user_id_by_cookie
          Zetto::Services::Cookie::FindUserId.new(@cookies).execute
        end


      end
    end
  end
end
