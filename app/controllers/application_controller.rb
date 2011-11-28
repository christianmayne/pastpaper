class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  
  def not_authenticated
    redirect_to root_url, :alert => "First login to access this page."
  end
  
  def logged_in_user
    redirect_to user_home_url and return if current_user
  end
  

end
