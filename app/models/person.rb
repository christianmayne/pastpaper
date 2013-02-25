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

	def ancestry_link
		cj_pid         = "6185997" #commission junction referral id
		first_name     = self.first_name
		middle_name    = self.middle_name
		last_name      = self.last_name
		birth_year     = self.event_year("birth")
		birth_location = self.event_location("birth")
		residence_location = self.event_location("residence")
		death_year     = self.event_year("death")
		death_location = self.event_location("death")

		# Determine which gender to exclude
		#if self.sex = "Male"
		#	ref_gender = "&_83004003-n_xcl=m"
		#elsif self.sex = "Female"
		#	ref_gender = "&_83004003-n_xcl=f"
		#else
			ref_gender = ""	
		#end	

		cj_url              = "http://www.dpbolvw.net/click-#{cj_pid}-10505988"
		ref_url             = "?url=http://search.ancestry.co.uk/cgi-bin/sse.dll?gl=ROOT_CATEGORY&rank=1&new=1&so=3&MSAV=1&msT=1&gss=ms_f-2_s"
		ref_first_name      = "&gsfn=#{first_name}+#{middle_name}"
		ref_last_name       = "&gsln=#{last_name}"
		ref_other_last_name = "&gsln_x=XO"
		ref_birth_year      = "&msbdy=#{birth_year}"
		ref_birth_location  = "&msbpn__ftp=#{birth_location}"
		ref_residence_location = "&msrpn__ftp=#{residence_location}"
		ref_death_year      = "&msddy=#{death_year}"
		ref_death_location  = "&msdpn__ftp=#{death_location}"
		ref_collection_priority = "&cp=0"
		other_params        = "&cpxt=1&catBucket=r&uidh=r62"

		return cj_url+ref_url+ref_first_name+ref_last_name+ref_other_last_name+ref_birth_year+ref_birth_location+ref_death_year+ref_death_location+ref_residence_location+ref_gender+ref_collection_priority+other_params
	end


	def event_year(event)
		unless self.facts.blank?
			event = self.facts.find(:first, :joins => :event_type, :conditions => ["UPPER(event_types.name) = '#{event}'"])
			return event.try(:fact_year)
		#else
		#	return "?"	
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
			if !fact.nil?
				if fact.location
					fact.location.full_location
				end	
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

		# If from date is higher than to date, swap over
		#if search_params[:date_from] > search_params[:date_to]
		#	temp = search_params[:date_from]
		#	search_params[:date_from] = search_params[:date_to]
		#	search_params[:date_to] = temp
		#end	

		condition  = ""
		condition += "UPPER(people.first_name) like  '%#{search_params[:first_name].upcase}%' AND " unless search_params[:first_name].blank?
		condition += "SOUNDEX(people.last_name) = SOUNDEX('#{search_params[:last_name]}') AND " unless search_params[:last_name].blank?
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