class Location < ActiveRecord::Base

  belongs_to :document
   validates :town,:presence => true
   validates :country ,:presence => true
  def full_location
    [self.street1, self.street2, self.town, self.county, self.state, self.country].delete_if{|ad_elem| ad_elem.blank?}.join(', ')
  end

end
