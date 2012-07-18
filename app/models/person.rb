class Person < ActiveRecord::Base
  belongs_to :document
  has_many :person_events, :dependent => :destroy
  has_many :event_types
  
  has_many :facts ,:dependent => :destroy

  accepts_nested_attributes_for :facts, :allow_destroy => true

  #validates :first_name,:presence => true
  #validates :last_name ,:presence => true
  
  validates :sex, :presence => true
  
  def sex_color
    unless self.sex.blank?
      if self.sex=='Male'
        '#D5DEEF'
      elsif self.sex=="Female"
        '#F7D2FD'
      else
        '#66666'
      end
    end
  end

  def sex_symbol
    #unless self.sex.blank?
    # (self.sex == 'Male') ? "&#9794" : "&#9792"
    #end
  end
  
  def birth_date  
     unless self.facts.blank?
      birth = self.facts.find(:first, :joins => :event_type, :conditions => ["UPPER(event_types.name) = 'BIRTH'"])
      return birth.try(:fact_year)
    else
      return "?"
    end  
  end
  
  def birth_location
     unless self.facts.blank?
      fact = self.facts.find(:first, :joins => :event_type, :conditions => ["UPPER(event_types.name) = 'BIRTH'"])
    if fact
      if fact.location
        fact.location.full_location
      end
   end
    else
    
    end           
  end
  
  def death_location
     unless self.facts.blank?
      fact = self.facts.find(:first, :joins => :event_type, :conditions => ["UPPER(event_types.name) = 'DEATH'"])
       if fact.location
        fact.location.full_location
      end
    else
    end           
  end
  
  def death_date  
     unless self.facts.blank?
      death = self.facts.find(:first, :joins => :event_type, :conditions => ["UPPER(event_types.name) = 'DEATH'"])
      return death.try(:fact_year)
    else
      return "?"
    end  
  end
  
  
  def event_date
    unless self.person_events.blank?
      birth = self.person_events.find(:first, :joins => :event_type, :conditions => ["event_types.name = 'Birth'"]).try(:date_event).strftime('%d %b %Y') rescue "?"
      death = self.person_events.find(:first, :joins => :event_type, :conditions => ["event_types.name = 'Death'"]).try(:date_event).strftime('%d %b %Y') rescue "?"
      return "#{birth} - #{death}"
    else
      return "? - ?"
    end
    
  
    
#    event = ""
#    unless self.person_events.blank?
#      self.person_events.each do |person_event|
#        if person_event.event_type.name == 'Birth'
#          event += person_event.date_event.blank? ? "ABT" : "#{person_event.date_event.strftime('%d %b %Y')}"
#          if !person_event.city.blank? || !person_event.county.blank? || !person_event.country.blank?
#            event += " ("
#            event += "#{person_event.try(:"city")}, " unless person_event.city.blank?
#            event += "#{person_event.try(:"county")}, " unless person_event.county.blank?
#            event += "#{person_event.try(:"country")}" unless person_event.country.blank?
#            event += ")"
#          end
#          event += " - "
#        end
#        if person_event.event_type.name == 'Death'
#          event += person_event.date_event.blank? ? "ABT" : "#{person_event.date_event.strftime('%d %b %Y')}"
#          if !person_event.city.blank? || !person_event.county.blank? || !person_event.country.blank?
#            event += " ("
#            event += "#{person_event.try(:"city")}, " unless person_event.city.blank?
#            event += "#{person_event.try(:"county")}, " unless person_event.county.blank?
#            event += "#{person_event.try(:"country")}" unless person_event.country.blank?
#            event += ")"
#          end
#        end
#      end
#      event += "? - ?" if event == ""
#    else
#      event += "? - ?"
#    end
#    return event
  end
 def person_events_except_dob
      begin
      res=   self.facts.find(:all, :joins => :event_type, :conditions => ["UPPER(event_types.name) != 'BIRTH' and UPPER(event_types.name) != 'DEATH' "],:order=>"person_events.date_event asc") 
      if !res.blank?
        return res
       else
         return nil
      end
      rescue 
        
      end  
  end
  
  def full_name
    "#{self.title} " + "#{self.first_name} " + " #{self.middle_name} " + "#{self.maiden_name} " + "#{self.last_name}"     
  end
  
  
end
