class Status < ActiveRecord::Base
  has_many :documents
  #scope :alphabetically, :order => "name ASC"
  default_scope order('statuses.name')

  validates :name ,:presence => true

  def self.for_filter
    self.where("UPPER(name) != 'HIDDEN'")
  end

end
