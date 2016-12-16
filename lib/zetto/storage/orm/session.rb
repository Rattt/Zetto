module Zetto::Storage::Orm

  class Session
    include ActiveModel::Model
    include Virtus.model

    AVAILABLE_ALGORITHMS = [ 'MD5', 'SHA1', 'RMD160', 'SHA256', 'SHA384', 'SHA512']

    attribute :user_id,    Integer
    attribute :session_id, Integer
    attribute :algorithm,   DateTime
  end

end