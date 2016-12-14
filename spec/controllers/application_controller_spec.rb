require 'rails_helper'

describe ApplicationController do

  describe "Check of inclusion of methods" do

    it "#create_session_for_user  has to be included" do
      expect(subject).to respond_to(:create_session_for_user)
    end

    it "#current_user  has to be included" do
      expect(subject).to respond_to(:current_user)
    end

  end

end


