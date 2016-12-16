module Zetto::Storage::Session::Data

  class Response

    def initialize(data)
      @session_id = data["session_id"]
      @user_id    = data["user_id"]
      @algorithm  = data["algorithm"]
    end

    def session_id
      return @session_id
    end

    def user_id
      return @user_id
    end

    def algorithm
      return @algorithm
    end

    def user
      Zetto::Config::Params.user_class.find_by(id: @user_id)
    end

  end

end