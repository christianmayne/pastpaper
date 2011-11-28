class UserMailer < ActionMailer::Base
  default from: "merosathilai@gmail.com"

  def activation_notification(user)
    @user = user
    @url  = user_activation_url(user.activation_token)
    mail(
      :to => user.email,
      :subject => "Thanks for signing up"
    )
  end
    
end
