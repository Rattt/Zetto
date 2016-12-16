module Zetto::Services::Session

  class Registration

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
      begin
        if session = Zetto::Storage::Tasks::Session::Create.new(@user).execute()
          create_cookie?(session)
        end
      rescue
        puts 'An error occurred Zetto::Services::Session::Registration'
        nil
      end
    end

    private

    def create_cookie?(session)
      !(Zetto::Services::Cookie::SaveSession.new(session, @cookies).execute.nil?)
    end

  end


end

