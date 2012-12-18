class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :document

	default_scope order('created_at DESC')

	def date_and_time
		self.created_at.strftime("%H:%M on %d %B %Y")
	end

end
