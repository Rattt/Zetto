module Zetto::Storage::Session::Data

  class Response < Zetto::Storage::Common::Response

    attr_reader :session_id, :user_id, :algorithm

    def initialize(data)
      @session_id = data["session_id"]
      @user_id    = data["user_id"]
      @algorithm  = data["algorithm"]

      self['session_id']  = data["session_id"]
      self['user_id']     = data["user_id"]
      self['algorithm']   = data["algorithm"]

      deep_freeze
    end

    def user
      Zetto::Config::Params.user_class.find_by(id: @user_id)
    end


  end

end