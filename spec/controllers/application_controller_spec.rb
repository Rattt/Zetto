require 'rails_helper'

describe ApplicationController do

  describe "Check of inclusion of methods" do

    it "#registration  has to be included" do
      expect(subject).to respond_to(:registration)
    end

    it "#current_user  has to be included" do
      expect(subject).to respond_to(:current_user)
    end

    it "#logout  has to be included" do
      expect(subject).to respond_to(:logout)
    end

  end

end


