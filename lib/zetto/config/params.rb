module Zetto
  module Config
    class Params
      @@user_class = ''
      class << self
        attr_accessor :user_class
      end
    end
  end
end