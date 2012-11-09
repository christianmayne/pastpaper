class UsersController < ApplicationController
	before_filter :require_login, :except => [:new,:create, :activate]
		
	def index
		@user = current_user
		@gedcom_link_text = "You have #{@user.gedcom_documents.size} Gedcom file"
		@gedcom_link_text += 's' if @user.gedcom_documents.size != 1
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			UserMailer.registration_notification(@user).deliver
			redirect_back_or_to root_url, :notice => "Registration successful!"
		else
			render :action => :new
		end
	end

	def edit
			@user = current_user
	end
	
	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			redirect_to user_home_path, :notice => "Information updated successful!"
		else
			render :action => :edit
		end
	end
	
	def changepassword
		@user = current_user
		if request.post?
			if params[:user][:password].blank?
				@user.errors[:base] << "New Password is blank."
				render :action => :changepassword
			else
				if @user.update_attributes(params[:user])
					flash[:notice] = "Password changed succesfully."
					redirect_to user_home_path
				else
					render :action => :changepassword
				end
			end 
		end
	end
	
	def accountdeactivate
		@user = current_user
				 
		if @user.update_attribute(:is_active, false)
			logout
			flash[:notice] = "Your account have been deactivated. In future if you need this account, please contact us."         
			redirect_to root_url
		else
			flash[:notice] = "Operation couldnot not be completed. Please try again "         
			redirect_to user_home_path
		end
	end  
 
	def activate
		# this method is not in active portion . this is for the system if there is signup process where confirmation via email is done.
		if @user = User.load_from_activation_token(params[:id])
			session[:user_id] = @user.id if @user.activate!
			redirect_to user_home_path, :notice => 'User was successfully activated.'
		else
			redirect_to root_url, :notice => 'Unable to activate your account. Try Again!'
		end
	end
 
end
