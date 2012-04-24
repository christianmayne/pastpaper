class AttributeDocument < ActiveRecord::Base

  belongs_to :document
  belongs_to :location
  belongs_to :attribute_type

validates :attribute_type_id ,:presence => true
validates :value ,:presence => true

validates :attribute_type_id ,:uniqueness => { :scope => [:attribute_type_id,:document_id]}

end
