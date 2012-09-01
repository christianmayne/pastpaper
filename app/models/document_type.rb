class DocumentType < ActiveRecord::Base
  has_many :documents
  
  scope :alphabetically, :order => "name ASC"

  scope :paper, where("paper = 1")
  scope :stone, where("stone = 1")

end
