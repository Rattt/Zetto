require "zetto/config/params"

module Zetto
  module Models

    class Session < ActiveRecord::Base

      belongs_to :user, class_name: Zetto::Config::Params.user_class, :foreign_key => 'user_id'

      # Только алгоритмы из Digest
      enum algorithm: [ 'MD5', 'SHA1', 'RMD160', 'SHA256', 'SHA384', 'SHA512']
      
      validates :user_id,    numericality:   { only_integer: true }, presence: true, uniqueness: { case_sensitive: false }
      validates :session_id, presence: true, length: { is: 9 }, uniqueness: { case_sensitive: false }
      validates :algorithm,  presence: true
    end

  end
end