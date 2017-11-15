class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?
  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  	#return this user if sessions user_id meaning that there is a user_id that stored in our browser (session hash)
  	#if so then find the user in th DB
  	#@current_user verifie if the curren t user is already exists ||= means if not
  end

  def logged_in?
  	!!current_user
  	#return true if a user is logged in
  end

  def require_user
  	if !logged_in?
  		flash[:danger] = "Il faut se connecter pour continuer "
  		redirect_to root_path
  	end
  end


end
