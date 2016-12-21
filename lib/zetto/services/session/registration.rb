module Zetto::Services::Session

  class Registration

    def initialize(user, cookies)
      Zetto::Config::Params.user_class(user.class.to_s)
      unless cookies.class.to_s == "ActionDispatch::Cookies::CookieJar"
        raise ArgumentError.new('To save session cookies needed, object of ActionDispatch::Cookies::CookieJar')
      end

      @user    = user
      @cookies = cookies
    end

    def execute
      begin
        if session = Zetto::Storage::Session::Create.new(@user).execute
          create_cookie(session)
        end
      rescue Exception => e
        puts e.message
        puts 'An error occurred Zetto::Services::Session::Registration'
        nil
      end
    end

    private

    def create_cookie(session)
      Zetto::Services::Cookie::SaveSession.new(session, @cookies).execute
    end

  end


end

