class Admin::ReportController < ApplicationController
 
  def index
     @people = Person.all
      @male_people = Person.where("SEX = ?","MALE")
   
    @female_people = Person.where("SEX = ?","FEMALE")
    @unknown_people = Person.where("SEX = ?","UNKNOWN")
    @unique_surnames = Person.count(:last_name,:distinct=>true)
     @surnames = Person.select("last_name,count(*) as last_name_count").group("last_name").where("last_name != ?","")
     
    
  end
  
  def surname_summary
    @unique_surnames = Person.select("last_name,count(*) as last_name_count").group("last_name")
  end
  
end
