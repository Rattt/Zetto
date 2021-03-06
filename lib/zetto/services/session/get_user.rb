module Zetto::Services::Session

  class GetUser

    def initialize(cookies, user_agent, remote_ip)
      unless cookies.class.to_s == "ActionDispatch::Cookies::CookieJar"
        raise ArgumentError.new(I18n.t('exseptions.save_session_cookies'))
      end

      @cookies = cookies
      @user_agent = user_agent
      @remote_ip = remote_ip
    end

    def execute
      find_user_by_cookie
    rescue Exception => e
      Zetto::Services::Info.error_message I18n.t('exseptions.unknown_error', argument: 'Zetto::Services::Session::GetUser', current_method: __method__), e
      nil
    end

    private

    def find_user_by_cookie
      session = Zetto::Services::Cookie::FindSession.new(@cookies).execute
      return nil if session.nil?
      user = session.user rescue nil
      return nil unless Digest::MD5.hexdigest(@user_agent) == session['user_agent']
      if Zetto::Config::Params.check_ip == true && @remote_ip != session['remote_ip']
        return nil
      end
      if Zetto::Config::Params.log
        logger = Zetto::Services::ZettoLogger.instance
        logger.info { I18n.t('log.connect')+" "+I18n.t('connect.success', field_name: user[Zetto::Config::Params.user_class_name], class_name: user.class.to_s, ip: @remote_ip.to_s) }
      end
      if session.soon_rotten?
        session = Zetto::Storage::Session::Create.new(user, @user_agent, @remote_ip).execute
        Zetto::Services::Cookie::SaveSession.new(session, @cookies).execute
      end
      user
    end

  end


end
