class ApplicationController < ActionController::Base
  protect_from_forgery
  alias :logged_in? :user_signed_in?
  alias :login_required :authenticate_user!
end
