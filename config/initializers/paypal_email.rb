PAYPAL_ACCOUNT = 'info@pastonpaper.com'
if !Rails.env.production?
  ActiveMerchant::Billing::Base.mode = :test
end
