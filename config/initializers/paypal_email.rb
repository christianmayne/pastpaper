if Rails.env.production?
  PAYPAL_ACCOUNT = 'bibek_1316595699_biz@gmail.com'
  ActiveMerchant::Billing::Base.mode = :test # for live transaction this line should be comented out or removed
else
  PAYPAL_ACCOUNT = 'bibek_1316595699_biz@gmail.com'
  ActiveMerchant::Billing::Base.mode = :test
end