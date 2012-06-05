class Admin::UsersController < ApplicationController
before_filter :require_admin

  def index
  	#@users=User.all.paginate(:page =>params[:page], :order =>'id desc', :per_page =>20)
    @users = User.all    
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])    
    if @user.save
      redirect_to admin_users_path, :notice => "New user was created successfully"
    else
      render :action => 'new'
    end
  end

  def edit
  		@user = User.find(params[:id]) 
  end

  def update
    @user = User.find(params[:id]) 
    if @user.update_attributes(params[:user])
      redirect_to admin_users_path, :notice => 'You have successfully updated user'
    else
      render :action => 'edit'
    end
  end
  def destroy
    @user = User.find(params[:id])
    @user.update_attribute("is_active",false)
   redirect_to :admin_users,:notice=>"You have Deactivated #{@user.email} user successfully"
   
    end

end
