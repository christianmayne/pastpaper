if Rails.env.production?
  PAYPAL_ACCOUNT = 'bibek_1316595699_biz@gmail.com'
else
  PAYPAL_ACCOUNT = 'bibek_1316595699_biz@gmail.com'
  ActiveMerchant::Billing::Base.mode = :test
end