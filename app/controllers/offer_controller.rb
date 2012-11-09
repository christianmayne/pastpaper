class OfferController < ApplicationController

	def new
		@document = Document.find_by_id(params[:document_id])
	end

	def create
		@document = Document.find_by_id(params[:document_id])
		if !params[:amount].blank? && params[:amount].to_s.to_f > 0.0
			@status = true
			@msg = "Offer has  been submitted."
			UserMailer.offer_notification_owner(current_user,@document,params[:amount]).deliver
			UserMailer.offer_notification_user(current_user,@document,params[:amount]).deliver
		else
			@msg = "Please fill the amount correctly."
			@status = false
		end
	end

end
