class UserMailer < ActionMailer::Base
  default from: "Pastonpaper.com <noreply@pastonpaper.com>"

  
    def registration_notification(user)
      @user = user
      @url  = root_url
      mail(
        :to => user.email,
        :subject => "Thank you for your registration in Pastonpaper"
      )
    end
  
  
  def reset_password_email(user)
    @user = user
    @url  = "http://www.pastpaper.com/password_resets/#{user.reset_password_token}/edit"
    mail(:to => user.email,
       :subject => "Your password has been reset")

  end
  
  #not implememnted
  def purchase_order_notification(order)
    @order= order
    
    mail(
      :to => @order.user.email,
      :subject => "Purchase order for your item: [#{@order.document_name}] in Pastonpaper"
    )
    
  end
  
  #not implememnted
  def activation_notification(user)
    @user = user
    @url  = user_activation_url(user.activation_token)
    mail(
      :to => user.email,
      :subject => "Thank you for your registration in Pastonpaper"
    )
  end
  
  def offer_notification_owner(user,document,amount)
    @user = user
    @document = document
     @amount = amount
    mail(
      :from => "Pastonpaper.com <noreply@pastonpaper.com>",
      :to => @document.user.email,
      :subject => "Offer on #{@document.display_name}"
    )
  end
  
  def offer_notification_user(user,document,amount)
    @user = user
    @document = document
    @amount = amount
    mail(
      :from =>  "Pastonpaper.com <noreply@pastonpaper.com>",
      :to => @user.email,
      :subject => "you have made an offer on #{@document.display_name}"
    )
  end
    
end
