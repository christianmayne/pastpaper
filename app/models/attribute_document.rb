class AttributeDocument < ActiveRecord::Base

  belongs_to :document
  belongs_to :location
  belongs_to :attribute_type

validates :attribute_type_id ,:presence => true
validates :value ,:presence => true

end
