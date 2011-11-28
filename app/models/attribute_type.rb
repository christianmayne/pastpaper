class AttributeType < ActiveRecord::Base

  has_many :documents
  scope :alphabetically, :order => "name ASC"
end
