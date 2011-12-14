if Rails.env.production?
  PAYPAL_ACCOUNT = 'production.paypal.account@domain.com'
else
  PAYPAL_ACCOUNT = 'bibek_1316595699_biz@gmail.com'
  ActiveMerchant::Billing::Base.mode = :test
end