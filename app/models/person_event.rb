class PersonEvent < ActiveRecord::Base

  belongs_to :person
  belongs_to :event_type
  
  scope :born, :conditions => {:event_type_id => 1}
  
  validates :event_type_id,:presence => true,:uniqueness => {:scope => :person_id ,:message=>"is already added"}

  
  def location
    [self.street1, self.street2, self.city, self.county, self.country].delete_if{|ad_elem| ad_elem.blank?}.join(', ')
  end

end
