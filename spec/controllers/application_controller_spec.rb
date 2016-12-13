require 'rails_helper'

describe ApplicationController do

  describe "Check of inclusion of methods" do

    it "#create_session_for_user?  has to be included" do
      expect(subject).to respond_to(:create_session_for_user?)
    end

    it "#current_user  has to be included" do
      expect(subject).to respond_to(:current_user)
    end

  end
=begin
  describe "create new session" do

    before(:all) do
      class User
        attr_accessor :id
        def new_record?;
          false;
        end
      end
      user = User.new
      user.id = 1
      @user = user
      Zetto::Config::Params.user_class = 'User'

      class CookieEmulator < Hash
        def class
          'ActionDispatch::Cookies::CookieJar'
        end
      end
      @cookies = CookieEmulator.new
    end

    it "#create_session_for_user? for which user has no session be true" do
      expect(subject.create_session_for_user?(@user)).to be true
    end

    it "#create_session_for_user? for which user has session be true" do
      subject.create_session_for_user?(@user)
      expect(subject.create_session_for_user?(@user)).to be true
    end

    it "#create_session_for_user? for for object no target class be false" do
      class NoTarget
        attr_accessor :id

        def new_record?;
          false;
        end
      end
      noTargetObj = NoTarget.new
      noTargetObj.id = 1
      expect(subject.create_session_for_user?(noTargetObj, @cookies)).to be false
    end

    it "#create_session_for_user? bad cookies object be false" do
      class CookieEmulatorBad < Hash ; end
      cookies = CookieEmulatorBad.new
      expect(subject.create_session_for_user?(@user)).to be false
    end

  end
=end
end


