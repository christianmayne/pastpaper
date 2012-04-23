class Fact < ActiveRecord::Base
belongs_to :person
belongs_to :event_type
belongs_to :location

validates :date_modifier ,:presence => true

end
