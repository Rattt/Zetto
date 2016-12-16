module Zetto::Storage::Session::Data

  class Response < Zetto::Storage::Common::Response

    attr_reader :session_id, :user_id, :algorithm, :time_live_s

    def initialize(data)
      @session_id  = data["session_id"]
      @user_id     = data["user_id"]
      @algorithm   = data["algorithm"]
      @time_live_s = data["time_live_s"]

      self['session_id']  = data["session_id"]
      self['user_id']     = data["user_id"]
      self['algorithm']   = data["algorithm"]
      self['time_live_s'] = data["time_live_s"]

      deep_freeze
    end

    def user
      Zetto::Config::Params.user_class.find_by(id: @user_id)
    end

    def soon_rotten?
      time_restart = Zetto::Config::Params.session_time_restart_min
      return false if time_restart <= 0
      time_restart = time_restart * 60
      self['time_live_s'] <= time_restart
    end

  end

end