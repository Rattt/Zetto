module Zetto::Services::Session

  class GetUser

    def initialize(cookies)
      unless cookies.class.to_s == "ActionDispatch::Cookies::CookieJar"
        raise ArgumentError.new('To save session cookies needed, object of ActionDispatch::Cookies::CookieJar')
      end

      @cookies = cookies
    end

    def execute
      begin
        find_user_by_cookie
      rescue
        puts 'An error occurred Zetto::Services::Session::GetUser'
        nil
      end
    end

    private

    def find_user_by_cookie
      session = Zetto::Services::Cookie::FindSession.new(@cookies).execute
      return nil if session.nil?
      user = session.user rescue nil
      if session.soon_rotten?
        session = Zetto::Storage::Session::Create.new(user).execute
        Zetto::Services::Cookie::SaveSession.new(session, @cookies).execute
      end
      user
    end

  end


end
