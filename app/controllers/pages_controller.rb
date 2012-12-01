class PagesController < ApplicationController

	def about
		@pagetitle="About The Past on Paper"
	end

	def contact
		@pagetitle="Contact Us"
	end

	def privacy
		@pagetitle="Privacy Policy"
	end

	def terms
		@pagetitle="Terms & Conditions"
	end
	
end
