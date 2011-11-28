class Status < ActiveRecord::Base
  has_many :documents
  scope :alphabetically, :order => "name ASC"

  validates :name ,:presence => true

end
