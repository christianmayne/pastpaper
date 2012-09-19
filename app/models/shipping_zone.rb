class ShippingZone < ActiveRecord::Base
  has_many :shipping_zone_prices
end
