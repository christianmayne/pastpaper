class UserMailer < ActionMailer::Base
  default from: "merosathilai@gmail.com"


  #not implememnted
  def activation_notification(user)
    @user = user
    @url  = user_activation_url(user.activation_token)
    mail(
      :to => user.email,
      :subject => "Thank you for your registration in Pastonpaper"
    )
  end
  
  def reset_password_email(user)
    @user = user
    @url  = "http://pastpaper.heroku.com/password_resets/#{user.reset_password_token}/edit"
    mail(:to => user.email,
       :subject => "Your password has been reset")

  end
  
  #not implememnted
  def purchase_order_notification(user, docuement)
    @user = user
    @document= docuement
    @owner= @docuemnt.user
    mail(
      :to => @owner.email,
      :subject => "Purchase order has been placed for your item in Pastonpaper"
    )
    
  end
    
end
