class Fact < ActiveRecord::Base
belongs_to :person
belongs_to :event_type
belongs_to :location

#validates :date_modifier ,:presence => true

validates :event_type_id,:presence => true,:uniqueness => {:scope => :person_id ,:message=>"is already added"}

def fact_month_string
  return Date::ABBR_MONTHNAMES[self.fact_month] unless self.fact_month.nil?
end

def fact_date_with_format
  [self.fact_day,self.fact_month_string,self.fact_year].delete_if{|d_elem| d_elem.blank?}.join('-')
end

end
