class OfferController < ApplicationController

	def new
		@document = Document.find_by_id(params[:document_id])
	end

	def create
		offer=Offer.new
		@document = Document.find_by_id(params[:document_id])
		if !params[:amount].blank? && params[:amount].to_s.to_f > 0.0
			@status = true
			@msg = "Your offer has  been submitted."
			offer.document_id = @document.id
			offer.user_id = current_user.id
			offer.amount=params[:amount]
			offer.save
			UserMailer.offer_notification_owner(current_user,@document,params[:amount]).deliver
			UserMailer.offer_notification_user(current_user,@document,params[:amount]).deliver
		else
			@msg = "You must enter an offer amount."
			@status = false
		end
	end

end
