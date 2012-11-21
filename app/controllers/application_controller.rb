class ApplicationController < ActionController::Base
	protect_from_forgery
	require 'rss'

private
	
	def not_authenticated
		redirect_to root_url, :alert => "First login to access this page."
	end
	
	def logged_in_user
		redirect_to user_home_url and return if current_user
	end
	
	def require_admin
		if !current_user
			not_authenticated
		else
			if current_user && !current_user.is_admin?
				redirect_to user_home_url, :alert => "Not authorised to access this page." and return     
			end
		end
	end
	
	def is_admin?
		if current_user
			if current_user.is_admin?
				return true
			end
			return false
		end
		return false
	end

end
