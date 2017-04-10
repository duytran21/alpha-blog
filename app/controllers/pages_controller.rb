class PagesController < ApplicationController

	def home  #this is action
		if logged_in?
			redirect_to articles_path
		end
	end


	def about

	end

end