class Admin::ReportController < ApplicationController
 
  def index
     @people = Person.all
     @male_people = Person.where("UPPER(sex) = ?","MALE".upcase)
   
    @female_people = Person.where("UPPER(sex) = ?","FEMALE".upcase)
    @unknown_people = Person.where("UPPER(sex) = ?","UNKNOWN".upcase)
    @unique_surnames = Person.count(:last_name,:distinct=>true)
    @surnames = Person.select("last_name,count(*) as last_name_count").group("last_name").where("last_name != ?","").order("last_name")
     
    
  end
  
  def surname_summary
    @unique_surnames = Person.select("last_name,count(*) as last_name_count").group("last_name")
  end
  
end
