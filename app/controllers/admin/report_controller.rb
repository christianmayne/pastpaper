class Admin::ReportController < ApplicationController
  before_filter :require_admin
   before_filter :prepare_country_array 
  def index
    @people = Person.all
    @male_people = Person.where("UPPER(sex) = ?","MALE".upcase)
   
    @female_people = Person.where("UPPER(sex) = ?","FEMALE".upcase)
    @unknown_people = Person.where("UPPER(sex) = ?","UNKNOWN".upcase)
    
    @surnames = Person.select("last_name,count(*) as last_name_count").group("last_name").where("last_name != ?","").order("last_name")
    @surnames_count = @surnames.to_a.size
    @documents = Document.all 
    @documents_by_types = Document.select("document_type_id,count(*) as document_type_count").group("document_type_id").order("document_type_id")
  
   
  
  
  
  end
  
  
  
  def surname_report
    @people = Person.all
    @male_people = Person.where("UPPER(sex) = ?","MALE".upcase)
   
    @female_people = Person.where("UPPER(sex) = ?","FEMALE".upcase)
    @unknown_people = Person.where("UPPER(sex) = ?","UNKNOWN".upcase)
    
   
    @surnames = Person.select("last_name,count(*) as last_name_count").group("last_name").where("last_name != ?","").order("last_name").paginate(:per_page=>100,:page=>params[:page])
    
  end
  
  def location_report
    
 
  @loc_chash = Hash.new
  @loc_thash = Hash.new
   @countries.each do |c|
      @towns = Array.new
      @counties = Array.new
      @counties_person_events   = PersonEvent.select("county").group("county").where("UPPER(country)=?",c.upcase).order("county")
      @counties_person_events.each{|ct| @counties << ct.county unless ct.county.nil? || ct.county.empty?}
     
      @counties_locations   = Location.select("county").group("county").where("UPPER(country)=?",c.upcase).order("county")
      @counties_person_events.each{|ct| @counties << ct.county unless ct.county.nil? || ct.county.empty?}
      @counties = @counties.uniq
      @loc_chash[c] = @counties
      
      @town_person_events   = PersonEvent.select("town").group("town").where("UPPER(country)=?",c.upcase).order("town")
      @town_person_events.each{|ct| @towns << ct.town unless ct.town.nil? || ct.town.empty?}
     
      @town_locations   = Location.select("town").group("town").where("UPPER(country)=?",c.upcase).order("town")
      @town_person_events.each{|ct| @towns << ct.town unless ct.town.nil? || ct.town.empty?}
     
      @towns = @towns.uniq
      @loc_thash[c] = @towns
    
  end
  end 
  
  def prepare_country_array
   @countries_person_events   = PersonEvent.select("country").group("country").order("country")
   @countries_other_locations=Location.select("country").group("country").order("country")
   
   @countries = Array.new
   @countries_person_events.each{|pel| @countries << pel.country}
   @countries_other_locations.each{|ol| @countries << ol.country}
   @countries.delete_if {|x| x == "" }   #=> ["a"]
   @countries = @countries.uniq
  end
end
