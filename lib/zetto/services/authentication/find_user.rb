module Zetto::Services::Authentication

  class FindUser
    include Zetto::Services::Cookie::Modules::Crypto

    def initialize(name, password)
      @user_class = Zetto::Config::Params.user_class
      access_attributes = [Zetto::Config::Params.user_class_name, Zetto::Config::Params.user_class_password]
      unless @user_class.column_names & access_attributes == access_attributes
        raise ArgumentError.new('Attribute name(user_class_name) or password(user_class_password) is not defined')
      end

      @name     = name
      @password = password
    end

    def execute
      begin
      name     = Zetto::Config::Params.user_class_name
      password = Zetto::Config::Params.user_class_password
      @user_class.where("#{name} = ? AND #{password} = ?", name, password).first
      rescue
        puts 'An error occurred Zetto::Services::Authentication::FindUser'
        nil
      end
    end

    private

  end

end