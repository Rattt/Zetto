#require "zetto/extension/action_controller_base"

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #include Zetto::Extension::ActionControllerBase

  def cookies
    Test::Emulators::Cookie.new
  end

  def request
    Test::Emulators::Request.new
  end

end





