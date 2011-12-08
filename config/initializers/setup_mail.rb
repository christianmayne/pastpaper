ActionMailer::Base.smtp_settings = {  
  :address => "smtp.gmail.com",  # put your smtp server
  :port => 587,   # your outbound port
  :domain => "gmail.com",  # put your gmail
  :user_name => "nasalupani", #put your site email  
  :password => "ambrosia977",   # put your password
  :authentication => "plain",  
  :enable_starttls_auto => true  
}  
ActionMailer::Base.default_url_options[:host] = "localhost:3000"
