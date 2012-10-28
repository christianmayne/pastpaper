class DocumentAttribute < ActiveRecord::Base

  belongs_to :document
  belongs_to :location
  belongs_to :attribute_type

	validates :attribute_type_id ,:presence => true
	validates :value ,:presence => true

	#validates :attribute_type_id ,:uniqueness => { :scope => [:attribute_type_id,:document_id]}

	def full_details
		[self.value, self.street1, self.street2, self.town, self.county, self.state, self.country].delete_if{|ad_elem| ad_elem.blank?}.join(', ')
	end

	def full_location
	  [self.street1, self.street2, self.town, self.county, self.state, self.country].delete_if{|ad_elem| ad_elem.blank?}.join(', ')
	end

	def full_date
	  date_string = ""
    date_string += self.date_modifier unless self.date_modifier.nil?
    date_string += " " +  self.attribute_day.to_s unless self.attribute_day.nil?
    date_string += " "+ Date::ABBR_MONTHNAMES[self.attribute_month] unless self.attribute_month.nil?
    date_string += " " + self.attribute_year.to_s unless self.attribute_year.nil?
    return date_string
	end


end
