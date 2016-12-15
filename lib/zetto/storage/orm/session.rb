module Zetto::Storage::Orm

  class Session
    include Virtus.model

    attribute :name, String
    attribute :age, Integer
    attribute :birthday, DateTime
  end

end