class GedcomDocument < ActiveRecord::Base

	belongs_to :user
	has_many :gedcom_people, :dependent => :destroy
	has_attached_file :file

end
