class MailingListsController < ApplicationController

	def index
	end

	def create
		if request.xhr?
			if !params[:first_name].blank? && !params[:last_name].blank? && !params[:email].blank?
				MailingListMailer.mailinglist_signup_notice_user(params[:first_name],params[:last_name],params[:email]).deliver
				MailingListMailer.mailinglist_signup_notice_admin(params[:first_name],params[:last_name],params[:email]).deliver
				@status = true
				@msg = "Thank you for signing up mailing list"
			else
				@status = false
				@msg = "Please fill all the fields"
			end
		end
	end

end
