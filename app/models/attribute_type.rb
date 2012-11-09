class AttributeType < ActiveRecord::Base

	has_many :documents
	has_many :attributes
	scope :alphabetically, :order => "name ASC"

end
