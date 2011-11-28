class People < ActiveRecord::Base
  belongs_to :document
  has_many  :person_events, :dependent=>:destroy
  
 
end
