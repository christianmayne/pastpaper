class UserMailer < ActionMailer::Base
  default from: "Past on Paper <info@pastonpaper.com>"

  # User Emails
  def registration_notification_user(user)
    @user = user
    @url  = root_url
    mail(
      :to => user.email,
      :subject => "Thank you for your registration on Pastonpaper.com"
    )
  end

  def registration_notification_admin(user)
    admin_user = User.find_by_username("administrator")
    @user = user
    @url  = root_url
    mail(
      :to => admin_user.email,
      :subject => "A new user has signed up to Pastonpaper.com"
    )
  end

  def reset_password_email(user)
    @user = user
    @url  = "http://www.pastonpaper.com/password_resets/#{user.reset_password_token}/edit"
    mail(:to => user.email,
       :subject => "Pastonpaper.com Password Reset Instructions")
  end

  def reset_password_confirmation(user)
    @user = user
    mail(:to => user.email,
       :subject => "Pastonpaper.com Password Successfully Changed")
  end


  # Document Emails
  def document_publish_confirmation(user)
    @user = user
    mail(:to => user.email,
         :subject => "You have successfully published your item on pastonpaper.com")
  end

  def document_unpublish_confirmation(user)
    @user = user
    mail(:to => user.email,
         :subject => "You have unpublished your item on pastonpaper.com")
  end

  def document_comment_notification(user, document)
    @user = user
    @document= document
    mail(:to => user.email,
         :subject => "A Comment has been left on your item at pastonpaper.com")
  end


  # Offer and Order Emails
  def purchase_order_notification(order)
    @order= order
    
    mail(
      :to => @order.user.email,
      :subject => "Purchase order for your item: [#{@order.document_name}] in Pastonpaper"
    )
    
  end

  def offer_notification_owner(user,document,amount)
    @user = user
    @document = document
    @amount = amount
    mail(
      :from => "Past on Paper <info@pastonpaper.com>",
      :to => @document.user.email,
      :subject => "Offer on #{@document.display_name}"
    )
  end
  
  def offer_notification_user(user,document,amount)
    @user = user
    @document = document
    @amount = amount
    mail(
      :from =>  "Past on Paper <info@pastonpaper.com>",
      :to => @user.email,
      :subject => "you have made an offer on #{@document.display_name}"
    )
  end

  
  #not implememnted
  def activation_notification(user)
    @user = user
    @url  = user_activation_url(user.activation_token)
    mail(
      :to => user.email,
      :subject => "Thank you for your registration on Pastonpaper.com"
    )
  end
  
    
end
