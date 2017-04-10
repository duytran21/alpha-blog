class SessionsController < ApplicationController
	#New action will show login form for user to login
	def new 

	end
	#Create action will submit form and open new user session.
	def create
		#render 'new'
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			session[:user_id] = user.id
			flash[:success] = "You have successfully logged in!"
			redirect_to user_path(user)
		else
			#when u render using flash.now and when u redirect_to using flash.
			flash.now[:danger] = "There is something wrong with your login information!"
			render 'new'
		end
	end
	#Destroy action = logout action.
	def destroy
		session[:user_id] = nil
		flash[:success] = "You have successfully logged out!"
		redirect_to root_path
	end
end