class Status < ActiveRecord::Base

	has_many :documents

	scope :alphabetically, :order => "name ASC"

	validates :name ,:presence => true

	def self.for_filter
		self.where("UPPER(name) != 'HIDDEN'")
	end

end
