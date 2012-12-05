class Person < ActiveRecord::Base

	belongs_to :document
	has_many :person_events, :dependent => :destroy
	has_many :event_types
	has_many :facts ,:dependent => :destroy
	accepts_nested_attributes_for :facts, :allow_destroy => true
	validates :sex, :presence => true

 
	def full_name
		"#{self.title} " + "#{self.first_name} " + " #{self.middle_name} " + "#{self.maiden_name} " + "#{self.last_name}"     
	end
	
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

	def event_year(event)
		unless self.facts.blank?
			event = self.facts.find(:first, :joins => :event_type, :conditions => ["UPPER(event_types.name) = '#{event}'"])
			return event.try(:fact_year)
		else
			return "?"	
		end  
	end

	def event_date(event)
		unless self.person_events.blank?
			event = self.person_events.find(:first, :joins => :event_type, :conditions => ["UPPERevent_types.name = '#{event}'"]).try(:date_event).strftime('%d %b %Y') rescue "?"
			return "#{event}"
		else
			return "?"
		end
	end

	def event_location(event)
		unless self.facts.blank?
			fact = self.facts.find(:first, :joins => :event_type, :conditions => ["UPPER(event_types.name) = '#{event}'"])
			if fact.location
				fact.location.full_location
			end
		end           
	end

	def event_county(event)
		unless self.facts.blank?
			fact = self.facts.find(:first, :joins => :event_type, :conditions => ["UPPER(event_types.name) = '#{event}'"])
			if fact.location
				fact.location.full_county
			end
		end           
	end

	def event_town(event)
		unless self.facts.blank?
			fact = self.facts.find(:first, :joins => :event_type, :conditions => ["UPPER(event_types.name) = '#{event}'"])
			if fact.location
				fact.location.full_town
			end
		end           
	end

	def person_events_all
		begin
			res = self.facts.find(:all, :joins => :event_type, :order=>"facts.fact_year asc") 
			if !res.blank?
				return res
			else
		 		return nil
			end
			rescue 
		end  
	end

	def person_events_except_dob
		begin
			res=self.facts.find(:all, :joins => :event_type, :conditions => ["UPPER(event_types.name) != 'BIRTH' and UPPER(event_types.name) != 'DEATH' "],:order=>"facts.fact_year asc") 
			if !res.blank?
				return res
			else
				return nil
			end
			rescue 	
		end  
	end

	
	def self.search_people(search_params,page,per_page=50)

		condition  = ""
		condition += "UPPER(people.first_name) like  '%#{search_params[:first_name].upcase}%' AND " unless search_params[:first_name].blank?
		condition += "UPPER(people.last_name) like '%#{search_params[:last_name].upcase}%' AND " unless search_params[:last_name].blank?

		# 
		unless condition.blank?
			condition += " status_id != 7 and is_deleted is false"
			self.paginate_by_sql("SELECT DISTINCT people.* FROM people
												LEFT JOIN documents ON documents.id = people.document_id
												WHERE #{condition} 
												ORDER BY last_name, first_name",:per_page=>per_page,:page=>page)
		else
			self.where("1=0").paginate(:per_page=>1,:page=>page)
		end
 	
	end


end