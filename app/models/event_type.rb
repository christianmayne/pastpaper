class EventType < ActiveRecord::Base

  has_many :person_event,:dependent => :destroy
  scope :alphabetically, :order => "name ASC"
  scope :sorted_all,:order => "sort_order asc"

end
