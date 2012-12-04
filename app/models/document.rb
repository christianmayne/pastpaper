class Document < ActiveRecord::Base

	has_many :document_attributes, :dependent => :destroy
	has_many :locations, :dependent => :destroy
	has_many :people, :dependent => :destroy
	has_many :document_photos, :dependent => :destroy
	has_many :document_facts
	has_many :facts, :through => :people

	belongs_to :document_type
	belongs_to :status
	belongs_to :user

	acts_as_taggable

	accepts_nested_attributes_for :document_attributes, :allow_destroy => :true
	accepts_nested_attributes_for :locations, :allow_destroy => :true
	accepts_nested_attributes_for :people, :allow_destroy => :true
	accepts_nested_attributes_for :document_photos, :allow_destroy => :true#,:limit => 4,:reject_if => proc { |attributes| attributes['photo'].blank? }

	validates :status_id ,:presence => true
	validates :sale_price,:presence=>true,:numericality=>true, :if => Proc.new { |document| document.status_id == 4 }
	validates :document_type_id ,:presence => true

	validates_numericality_of :weight, :width, :length, :depth, :message => "only number allowed", :allow_blank => true
	validates_inclusion_of :weight, :in => 0..30000, :message => "should be less than 30000", :allow_blank => true
	validates_inclusion_of :width, :in  => 1..1000, :message => "should be between 1 and 1000", :allow_blank => true
	validates_inclusion_of :length, :in => 1..1000, :message => "should be between 1 and 1000", :allow_blank => true
	validates_inclusion_of :depth, :in  => 0..1000, :message => "should be less than 1000", :allow_blank => true

	scope :show_latest_documents, joins(:status).where(:statuses => {:show_latest_items => ["1"]})
	scope :show_featured_documents,joins(:status).where(:is_featured => ["1"], :statuses => {:show_featured_items => ["1"]})
	scope :has_photos, joins(:document_photos).group("document_id")

	def self.per_page
		50
	end

	def display_name
		self.name ? self.name : self.title
	end

	def document_status
		unless self.status.blank?
			self.status.name
		else
			''
		end
	end

	def is_on_sale?
		if self.status.blank?
			return false
		else
			if "For Sale" == self.status.name
				return true
			else
				return false
			end
		end
	end

	def document_type_name
		unless self.document_type.blank?
			self.document_type.name
		else
			''
		end
	end

	def reference_number
		if self.stock_number.blank?
			return self.id.to_s
		else
			return self.id.to_s + "/" + self.stock_number
		end
	end

	def shipping_price
		doc_id = self.id
		shipping_price = ShippingZonePrice.find_by_sql("SELECT z.price as price
																										FROM shipping_zone_prices z, documents d
																										WHERE d.id = '#{doc_id}'
																										AND z.weight_g > d.weight
																										ORDER BY z.weight_g asc limit 1").first.try(:price)
		if shipping_price == nil
			shipping_price = 0
		end
 
		return shipping_price
	end

	def shipping_price_new
	end

	def last_name_list
		list = self.people.select("DISTINCT last_name").order("last_name ASC")
		list_string = list.map { |f| f.last_name }.join ', '
		return list_string.reverse.sub(/,/, ' dna ').reverse
	end

	def earliest_fact_year
		min = self.facts.where("fact_year > 0").first(:order => 'fact_year asc');
		if min.nil?
			return 0
		else
			return min.fact_year
		end
	end

	def latest_fact_year
		max = self.facts.where("fact_year > 0").first(:order => 'fact_year desc');
		if max.nil?
			return 0
		else
			return max.fact_year
		end
	end


	def self.simple_search(search_param)
		condition  = ""
		condition += "documents.document_type_id = '#{search_param[:document_type_id]}' OR " unless search_param[:document_type_id].blank?
		condition += "documents.status = '#{search_param[:socument_status_id]}' OR " unless search_param[:document_status_id].blank?
		condition += "documents.title LIKE '%#{search_param[:document_title]}%' OR " unless search_param[:document_title].blank?
		condition += "attribute_types.name = 'publisher' AND document_attributes.value = '#{search_param[:document_publisher]}' OR " unless search_param[:document_publisher].blank?
		condition += "attribute_types.name = 'author' AND document_attributes.value = '#{search_param[:document_author]}' OR " unless search_param[:document_author].blank?
		condition += "people.name_first = '#{search_param[:firstname]}' OR " unless search_param[:firstname].blank?
		condition += "people.name_maiden = '#{search_param[:lastname]}' OR " unless search_param[:lastname].blank?
		condition += "YEAR(person_events.date_event) >= '#{search_param[:date_birth_from]}'
									AND YEAR(person_events.date_event) >= '#{search_param[:date_birth_to]}'
									AND event_types.name = 'Birth' OR " unless search_param[:date_birth_from].blank? && search_param[:date_birth_to].blank?
		condition += "person_events.city = '#{search_param[:city]}' AND event_types.name = 'Birth' OR " unless search_param[:city].blank?
		condition += "person_events.county = '#{search_param[:county]}' AND event_types.name = 'Birth' OR " unless search_param[:county].blank?
		condition += "person_events.country = '#{search_param[:country]}' AND event_types.name = 'Birth' OR " unless search_param[:country].blank?
		condition += "YEAR(person_events.date_event) = '#{search_param[:date_death_from]}'
									AND event_types.name = 'Death' OR " unless search_param[:date_death_from].blank?
		condition += "YEAR(person_events.date_event) >= '#{search_param[:date_other_from]}'
									AND YEAR(person_events.date_event) <= '#{search_param[:date_other_to]}'
									AND event_types.name <> 'Birth' AND event_types.name <> 'Death' OR " unless search_param[:date_other_from].blank? && search_param[:date_other_to].blank?
		condition += "locations.city = '#{search_param[:city]}' OR " unless search_param[:city].blank?
		condition += "locations.city = '#{search_param[:county]}' OR " unless search_param[:county].blank?
		condition += "locations.city = '#{search_param[:country]}' OR " unless search_param[:country].blank?
		unless condition.blank?
			condition += " 1 = 1 "
			self.find_by_sql("SELECT DISTINCT documents.* FROM documents
												LEFT JOIN users ON users.id = documents.user_id
												LEFT JOIN document_types ON document_types.id = documents.document_type_id
												LEFT JOIN document_statuses ON document_statuses.id = documents.document_status_id
												LEFT JOIN document_attributes ON document_attributes.document_id = documents.id
												LEFT JOIN attribute_types ON attribute_types.id = document_attributes.attribute_type_id
												LEFT JOIN people ON people.document_id = documents.id
												LEFT JOIN person_events ON person_events.person_id = people.id
												LEFT JOIN event_types ON event_types.id = person_events.event_type_id
												LEFT JOIN locations ON locations.document_id = documents.id
												WHERE #{condition}")
		end
	end


	def self.search_people(search_params,page,per_page=50)
		search_params[:date_birth_to] = '0' if search_params[:date_birth_to].blank?
		if !search_params[:date_birth_from].blank?
			date_birth_from = search_params[:date_birth_from].to_i
			unless search_params[:date_birth_to] == '0'
				date_birth_from = search_params[:date_birth_from].to_i - search_params[:date_birth_to].to_i
				date_birth_to = search_params[:date_birth_from].to_i + search_params[:date_birth_to].to_i
			end
		end

		search_params[:date_death_to] = '0' if search_params[:date_death_to].blank?
		if !search_params[:date_death_from].blank?
			date_death_from = search_params[:date_death_from].to_i
			unless search_params[:date_death_to] == '0'
				date_death_from = search_params[:date_death_from].to_i - search_params[:date_death_to].to_i
				date_death_to = search_params[:date_death_from].to_i + search_params[:date_death_to].to_i
			end
		end

		condition  = ""
		condition += "UPPER(people.first_name) like  '%#{search_params[:first_name].upcase}%' AND " unless search_params[:first_name].blank?
		condition += "UPPER(people.last_name) like '%#{search_params[:last_name].upcase}%' AND " unless search_params[:last_name].blank?

		if !date_birth_from.blank? && !date_birth_to.blank?
			condition += " facts.fact_year >= '#{date_birth_from}' AND UPPER(event_types.name) = 'BIRTH'  AND "
			condition += " facts.fact_year <= '#{date_birth_to}' AND UPPER(event_types.name) = 'BIRTH'  AND "
		elsif !date_birth_from.blank? && date_birth_to.blank?
			condition += " facts.fact_year = '#{date_birth_from}' AND UPPER(event_types.name) = 'BIRTH' AND "
		end

		if !date_death_from.blank? && !date_death_to.blank?
			condition += " facts.fact_year >= '#{date_death_from}' AND UPPER(event_types.name) = 'DEATH'  AND "
			condition += " facts.fact_year <= '#{date_death_to}' AND UPPER(event_types.name) = 'DEATH' AND "
		elsif !date_death_from.blank? && date_death_to.blank?
			condition += " facts.fact_year = '#{date_death_from}' AND UPPER(event_types.name) = 'DEATH' AND "
		end

		if !search_params[:document_type_id].blank?
			condition += " documents.document_type_id = '#{search_params[:document_type_id]}'  AND "
		end

		if !search_params[:document_status].blank?
			condition += " documents.status_id = '#{search_params[:document_status]}'  AND "
		end

		unless condition.blank?
			condition += " status_id != 7 and is_deleted is false"
			self.paginate_by_sql("SELECT DISTINCT documents.* FROM documents
												LEFT JOIN users ON users.id = documents.user_id
												LEFT JOIN document_types ON document_types.id = documents.document_type_id
												LEFT JOIN statuses ON statuses.id = documents.status_id
												LEFT JOIN document_attributes ON document_attributes.document_id = documents.id
												LEFT JOIN attribute_types ON attribute_types.id = document_attributes.attribute_type_id
												LEFT JOIN people ON people.document_id = documents.id
												LEFT JOIN facts ON facts.person_id = people.id
												LEFT JOIN event_types ON event_types.id = facts.event_type_id
												WHERE #{condition} ",:per_page=>per_page,:page=>page)
		else
			self.where("1=0").paginate(:per_page=>1,:page=>page)
		end

	end


	def self.search_location(search_params,page,per_page=50)
		condition_str  = ""

		if !search_params[:date_from].blank?
			date_from = search_params[:date_from].to_i
		end
		if !search_params[:date_to].blank?
			date_to = search_params[:date_to].to_i
		end

		condition_str += "(UPPER(locations.town) like '%#{search_params[:city].upcase}%' OR UPPER(locations.town) like '%#{search_params[:city].upcase}%') AND " unless search_params[:city].blank?
		condition_str += "(UPPER(locations.county) like '%#{search_params[:county].upcase}%' OR UPPER(locations.county) like '%#{search_params[:county].upcase}%') AND " unless search_params[:county].blank?
		condition_str += "(UPPER(locations.country) like '%#{search_params[:country].upcase}%' OR UPPER(locations.country) like '%#{search_params[:country].upcase}%') AND " unless search_params[:country].blank?

		condition_str += "(extract(year FROM facts.fact_year) >= '#{date_from}' AND extract(year FROM facts.fact_year) <= '#{date_to}') AND " if !date_from.blank? && !date_to.blank?
		if !search_params[:document_type_id].blank?
			condition_str += " documents.document_type_id = '#{search_params[:document_type_id]}'  AND "
		end
		if !search_params[:document_status].blank?
			condition_str += " documents.status_id = '#{search_params[:document_status]}'  AND "
		end

		unless condition_str.blank?
			condition_str += " status_id != 7 and is_deleted is false"
			self.paginate_by_sql("SELECT DISTINCT documents.* FROM documents
												LEFT JOIN users ON users.id = documents.user_id
												LEFT JOIN document_types ON document_types.id = documents.document_type_id
												LEFT JOIN statuses ON statuses.id = documents.status_id
												LEFT JOIN document_attributes ON document_attributes.document_id = documents.id
												LEFT JOIN attribute_types ON attribute_types.id = document_attributes.attribute_type_id
												LEFT JOIN people ON people.document_id = documents.id
												LEFT JOIN facts ON facts.person_id = people.id
												LEFT JOIN event_types ON event_types.id = facts.event_type_id
												LEFT JOIN locations ON locations.document_id = documents.id
												WHERE #{condition_str} ",:per_page => per_page,:page => page)
		else
			self.where("1=0").paginate(:per_page=>1,:page=>page)
		end
	end



	def self.search_date(search_params,page,per_page=50)
		condition_str  = ""

		if !search_params[:dd].blank?
			dd = search_params[:dd].to_i
			condition_str += "#{dd} "
		end
		if !search_params[:mm].blank?
			mm = search_params[:mm].to_i
			condition_str += "#{mm} "
		end
		if !search_params[:yyyy].blank?
			yyyy = search_params[:yyyy].to_i
			condition_str += " #{yyyy} "
		end

		unless condition_str.blank?
			self.paginate_by_sql("SELECT * from facts
														LEFT JOIN people on people.id = facts.person_id
														LEFT JOIN documents on documents.id = people.document_id
														WHERE fact_year = #{yyyy}
														GROUP BY documents.id", :per_page => per_page,:page => page)
		else
			self.where("1=0").paginate(:per_page=>1,:page=>page)
		end
	end



	def self.search_publication(search_params,page,per_page=50)
		condition  = ""

		if !search_params[:date_from].blank?
			date_from = search_params[:date_from].to_i
		end
		if !search_params[:date_to].blank?
			date_to = search_params[:date_to].to_i
		end

		condition += "UPPER(documents.title) like '%#{search_params[:document_title].upcase}%' AND " unless search_params[:document_title].blank?
		condition += "attribute_types.name = 'Publisher' AND UPPER(document_attributes.value) like '%#{search_params[:document_publisher].upcase}%' AND " unless search_params[:document_publisher].blank?
		condition += "attribute_types.name = 'Author' AND UPPER(document_attributes.value) like '%#{search_params[:document_author].upcase}%' AND " unless search_params[:document_author].blank?
		if !search_params[:document_type_id].blank?
			condition += " documents.document_type_id = '#{search_params[:document_type_id]}'  AND "
		end
		if !search_params[:document_status].blank?
			condition += " documents.status_id = '#{search_params[:document_status]}'  AND "
		end
		#puts condition
		unless condition.blank?
			condition += " status_id != 7 and is_deleted is false"

			# this need to be changed later for hidden status_id=7
			self.paginate_by_sql("SELECT DISTINCT documents.* FROM documents
												LEFT JOIN users ON users.id = documents.user_id
												LEFT JOIN document_types ON document_types.id = documents.document_type_id
												LEFT JOIN statuses ON statuses.id = documents.status_id
												LEFT JOIN document_attributes ON document_attributes.document_id = documents.id
												LEFT JOIN attribute_types ON attribute_types.id = document_attributes.attribute_type_id
												LEFT JOIN people ON people.document_id = documents.id
												LEFT JOIN facts ON facts.person_id = people.id
												LEFT JOIN event_types ON event_types.id = facts.event_type_id
												LEFT JOIN locations ON locations.document_id = documents.id
												WHERE #{condition} ",:per_page => per_page,:page => page)
		else
			self.where("1=0").paginate(:per_page=>1,:page=>page)
		end
	end

	def people_list(firstname, lastname)
		self.people.find(:all, :conditions => ["name_first =? AND name_last =? ", "#{firstname}", "#{lastname}"]) unless self.people.blank?
	end

	def default_image
		unless self.document_photos.nil?
			primary_image = self.document_photos.find(:first,:conditions=>["is_primary is true"])
			if primary_image.nil?
				return self.document_photos.first
			else
				return primary_image
			end
		end
		return nil
	end
end