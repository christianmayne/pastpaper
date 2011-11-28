class SessionsController < ApplicationController
  def create
    user = login(params[:username],params[:password])
    if user
      redirect_back_or_to user_home_path, :notice => 'You are successfully Logged in'
    else
      redirect_back_or_to root_url, :alert => 'Email or password is invalid'
    end
  end
  
  def destroy
    logout
    redirect_to root_url, :notice => 'Logged out successfully.'
  end

end
