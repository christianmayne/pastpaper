class Location < ActiveRecord::Base

  belongs_to :document
  validates :town,:presence => true
  validates :country ,:presence => true

end
