module Zetto::Services::Session

  class Registration

    def initialize(user, cookies, user_agent, remote_ip)
      Zetto::Config::Params.user_class(user.class.to_s)
      unless cookies.class.to_s == "ActionDispatch::Cookies::CookieJar"
        raise ArgumentError.new('To save session cookies needed, object of ActionDispatch::Cookies::CookieJar')
      end

      @user = user
      @cookies = cookies
      @user_agent = user_agent
      @remote_ip = remote_ip
    end

    def execute
      if session = Zetto::Storage::Session::Create.new(@user, @user_agent, @remote_ip).execute
        create_cookie(session)
      end
    rescue Exception => e
      Zetto::Services::Info.error_message I18n.t('exseptions.unknown_error', argument: 'Zetto::Services::Session::Registration', current_method: __method__), e
      nil
    end

    private

    def create_cookie(session)
      Zetto::Services::Cookie::SaveSession.new(session, @cookies).execute
    end

  end


end

