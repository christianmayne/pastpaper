class MailingListMailer < ActionMailer::Base
  default from: "Pastonpaper.com <noreply@pastonpaper.com>"

  def mailinglist_signup_notice_user(fname,lname,email)
     @fname = fname
      mail(
        :to => email,
        :from => "Christian Mayne <christian@pastonpaper.com>",
        :subject => "I've added you to the pastonpaper.com mailing list"
      )
  end
  
  def mailinglist_signup_notice_admin(fname,lname,email)
    
     @admin = User.where("email = 'info@pastonpaper.com'").first 
    
    if !@admin.blank?
      to_email = @admin.email
    else
      to_email = "info@pastonpaper.com"
    end
     @fname = fname
     @email = email
     @lname = lname 
      mail(
        :from => email,      
        :to => to_email,
         :subject => "#{fname} #{lname} has joined the Pastonpaper.com mailing list"
      )
  end
  
    
end
