class PersonEvent < ActiveRecord::Base

  DATE_MODIFIERS= [["BEFORE","BEF"],["ABOUT","ABT"],["ESTIMATED","EST"],["AFTER","AFT"]]
  
  belongs_to :person
  belongs_to :event_type
  
  scope :born, :conditions => {:event_type_id => 1}
  
  validates :event_month, :numericality => { :only_integer => true,:less_than_or_equal_to => 12,:greater_than_or_equal_to =>01 }
  validates :event_day, :numericality => { :only_integer => true,:less_than_or_equal_to => 31,:greater_than_or_equal_to =>01 }
  validates :event_year, :numericality => { :only_integer => true }
  
  # validates :date_modifier
  validates :event_type_id,:presence => true,:uniqueness => {:scope => :person_id ,:message=>"is already added"}
  
  def location
    [self.street1, self.street2, self.city, self.county, self.country].delete_if{|ad_elem| ad_elem.blank?}.join(', ')
  end

  def event_date
    date_string = ""
     #return self.event_year
    date_string += self.date_modifier unless self.date_modifier.nil?
    date_string += " " +  self.event_day.to_s unless self.event_day.nil?
     
    date_string += " "+ Date::ABBR_MONTHNAMES[self.event_month] unless self.event_month.nil?
    
    date_string += " " + self.event_year.to_s unless self.event_year.nil?
   
  return date_string
  end 
    
  
end
