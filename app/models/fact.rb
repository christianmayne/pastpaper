class Fact < ActiveRecord::Base

	belongs_to :person
	belongs_to :event_type
	belongs_to :location

	validates :event_type_id,:presence => true

	def fact_day_string
		return self.fact_day.ordinalize unless self.fact_day.nil?
	end

	def fact_month_string_abbrev
		return Date::ABBR_MONTHNAMES[self.fact_month] unless self.fact_month.nil?
	end

	def fact_month_string
		return Date::MONTHNAMES[self.fact_month] unless self.fact_month.nil?
	end

	def fact_date_with_format_old
		[self.fact_day,self.fact_month_string_abbrev,self.fact_year].delete_if{|d_elem| d_elem.blank?}.join('-')
	end

	def fact_date_with_format
		[self.date_modifier,self.fact_day_string,self.fact_month_string,self.fact_year].delete_if{|d_elem| d_elem.blank?}.join(' ')
	end

end
