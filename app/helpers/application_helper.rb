# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

	def site
		SiteProfile.first
	end

	def fb_dimg
		"#{request.protocol}#{request.host_with_port}/logo.jpg"
	end	

	def current_url
		"#{request.protocol}#{request.host_with_port}#{request.fullpath}"
    end

	def link_to_remove_fields(name, f, mode)
		f.hidden_field(:_destroy) + link_to_function(name, "#{mode}_fields(this)")
	end

	def link_to_add_fields(name, f, association, mode)
		new_object = f.object.class.reflect_on_association(association).klass.new
		fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
			render(association.to_s.singularize + "_fields", :f => builder)
		end
		link_to_function(name, ("#{mode}_fields(this, '#{association}', '#{escape_javascript(fields)}')"))
	end

	##
	# Returns an array of Genders for use in forms
	def people_gender
		[["Unknown", "Unknown"],["Male", "Male"], ["Female", "Female"]]
	end

	##
	# Returns list of all countries within the location_countries table
	def location_countries
		return LocationCountry.find :all, :order=>"sort_order, name ASC"
	end

	##
	# Returns a html formatted 728x90 banner ad from a pre-defined array within the method
	def banner_ad
		banner_ads  = 
		['<a href="http://www.anrdoezrs.net/click-6185997-10660760" target="_top"><img src="http://www.ftjcfx.com/image-6185997-10660760" width="728" height="90" alt="728x90: Free trial" border="0"/></a>',
		 '<a href="http://www.anrdoezrs.net/click-6185997-10660758" target="_top"><img src="http://www.lduhtrp.net/image-6185997-10660758" width="728" height="90" alt="728x90: Free trial" border="0"/></a>',
		 '<a href="http://www.tkqlhce.com/click-6185997-10660751" target="_top"><img src="http://www.lduhtrp.net/image-6185997-10660751" width="728" height="90" alt="728x90: Free trial" border="0"/></a>',
		 '<a href="http://www.anrdoezrs.net/click-6185997-10880818" target="_top"><img src="http://www.ftjcfx.com/image-6185997-10880818" width="728" height="90" alt="14 Day Free Trial " border="0"/></a>',
		 '<a href="http://www.jdoqocy.com/click-6185997-10660719" target="_top"><img src="http://www.ftjcfx.com/image-6185997-10660719" width="728" height="90" alt="728x90_Genes Reunited" border="0"/></a>',
		 '<a href="http://www.dpbolvw.net/click-6185997-10931192" target="_top"><img src="http://www.tqlkg.com/image-6185997-10931192" width="728" height="90" alt="" border="0"/></a>',
		 '<a href="http://www.jdoqocy.com/click-6185997-10931171" target="_top"><img src="http://www.lduhtrp.net/image-6185997-10931171" width="728" height="90" alt="" border="0"/></a>',
		 '<a href="http://www.kqzyfj.com/click-6185997-10931162" target="_top"><img src="http://www.tqlkg.com/image-6185997-10931162" width="728" height="90" alt="" border="0"/></a>']

		return banner_ads[rand(banner_ads.count)].html_safe
	end


	## 
	# Returns the latest documents with photos
	#
	# TODO: Enable the return of items regardless of photo exitence
	def latest_items(items)
		latest_items = Document.show_latest_documents.has_photos.last(items)
	end	


	##
	# Returns a random collection of Documents
	def random_items(items)
		random_items = Document.has_photos.find(:all, :limit => items, :order => "RAND()")
	end
	

	##
	# Returns a distinct list of all countries referenced by documents
	def db_countries
		Location.find :all, :order=>"country ASC", :select => "DISTINCT country"
	end


	## 
	# Returns an array of Months mapped to their numerical value
	def month_array
		[["	January", "1"],["February", "2"], 
		["March", "3"],["April",4],
		["May",5],["June",6],
		["July",7],["August",8],
		["September",9],["October",10],
		["November",11],["December",12]]
	end


end
