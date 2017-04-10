class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # the purpose of assigning this line is 
  # by default all the method you defined in application controller will
  # only availabel in controller folder not availabel for view
  # (or anything outside). To use in different folder especially
  # in view we will assign helper_method to adapt that situation.
  helper_method :current_user, :logged_in?

  def current_user
  	# the purpose of this line is only set current user's value when
  	# it's value is nil to avoid requesting many times on database.
  	#debugger
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


  def logged_in?
  	!!current_user
  end

  def require_user
  	if !logged_in?
  		flash[:danger] = "You must be logged in to perform this action!"
  		redirect_to root_path
  	end
  end

end
