class SessionsController < ApplicationController
  def create
   
    user = login(params[:username],params[:password],params[:remember_me])
    if user
      if !user.is_active?
       logout
        redirect_to root_path, :alert => 'Your account has been deactivated. Please contact the administrator to activate your account' and return
      
      end
      redirect_back_or_to user_home_path, :notice => 'You are successfully Logged in'
    else
      redirect_back_or_to root_url, :alert => 'Email or password is invalid'
    end
  end
  
  def destroy
    logout
    redirect_to root_url, :notice => 'Logged out successfully.'
  end
  
  def forgot_password
    
  end

end
