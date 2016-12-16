module Zetto::Storage::Session::Data

  class Response

    attr_reader :session_id, :user_id, :algorithm

    def initialize(data)
      @session_id = data["session_id"]
      @user_id    = data["user_id"]
      @algorithm  = data["algorithm"]
    end

    def user
      Zetto::Config::Params.user_class.find_by(id: @user_id)
    end

  end

end