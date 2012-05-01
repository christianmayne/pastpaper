class Fact < ActiveRecord::Base
belongs_to :person
belongs_to :event_type
belongs_to :location

#validates :date_modifier ,:presence => true

validates :event_type_id,:presence => true,:uniqueness => {:scope => :person_id ,:message=>"is already added"}

end
