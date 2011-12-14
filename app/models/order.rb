class Order < ActiveRecord::Base
belongs_to :document
belongs_to :user,:foreign_key =>"seller_id"

end
