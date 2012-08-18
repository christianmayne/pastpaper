class DocumentType < ActiveRecord::Base
  has_many :documents
  #scope :alphabetically, :order => "name ASC"
  default_scope order('document_types.name')  

end
