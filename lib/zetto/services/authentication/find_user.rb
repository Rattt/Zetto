module Zetto::Services::Authentication

  class FindUser

    include Zetto::Modules::Crypto

    def initialize(class_name, name, password)
      @user_class = Zetto::Config::Params.user_class(class_name)
      access_attributes = [Zetto::Config::Params.user_class_name, Zetto::Config::Params.user_class_password]
      unless @user_class.column_names & access_attributes == access_attributes
        raise ArgumentError.new('Attribute name(user_class_name) or password(user_class_password) is not defined')
      end

      @name = name
      @password = password
    end

    def execute
      name = Zetto::Config::Params.user_class_name
      password = Zetto::Config::Params.user_class_password
      @user_class.where("#{name} = ? AND #{password} = ?", @name, @password).first
    rescue Exception => e
      Zetto::Services::Info.error_message I18n.t('exseptions.unknown_error', argument: 'Zetto::Services::Authentication::FindUser', current_method: __method__), e
      nil
    end

  end

end