class Location < ActiveRecord::Base

	belongs_to :document
	has_many :facts

	def full_location
		[self.street1, self.street2, self.town, self.county, self.state, self.country].delete_if{|ad_elem| ad_elem.blank?}.join(', ')
	end

	def full_town
		[self.town, self.county, self.state, self.country].delete_if{|ad_elem| ad_elem.blank?}.join(', ')
	end

	def full_county
		[self.county, self.state, self.country].delete_if{|ad_elem| ad_elem.blank?}.join(', ')
	end

	def self.search_location(search_params,page,per_page=50)
		condition_str  = ""

		condition_str += "(UPPER(locations.town) like '%#{search_params[:city].upcase}%' OR UPPER(locations.town) like '%#{search_params[:city].upcase}%') AND " unless search_params[:city].blank?
		condition_str += "(UPPER(locations.county) like '%#{search_params[:county].upcase}%' OR UPPER(locations.county) like '%#{search_params[:county].upcase}%') AND " unless search_params[:county].blank?
		condition_str += "(UPPER(locations.country) like '%#{search_params[:country].upcase}%' OR UPPER(locations.country) like '%#{search_params[:country].upcase}%') AND" unless search_params[:country].blank?
		condition_str += "(1=1)"
		unless condition_str.blank?
			#condition_str += " status_id != 7 and is_deleted is false"
			#self.paginate_by_sql("SELECT DISTINCT locations.* FROM locations
			#										LEFT JOIN documents ON documents.id = locations.document_id
			#										WHERE #{condition_str} 
			#										ORDER BY country, state, county, town",:per_page => per_page,:page => page)
			self.where(condition_str).paginate(:per_page=>per_page,:page=>page)
		else
			self.where("1=0").paginate(:per_page=>1,:page=>page)
		end
	end

end

