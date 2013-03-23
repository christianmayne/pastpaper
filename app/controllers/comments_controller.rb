class CommentsController < ApplicationController
	before_filter :load_document


	def create
		@comment = @document.comments.new(params[:comment])
		@comment.user = current_user
		if @comment.save
			redirect_to @document, :notice=> 'Thank you for your comment'
			UserMailer.document_comment_notification(@document.user, @document).deliver
		else
			redirect_to @document, :alert=> 'Sorry, we were unable to add your comment'
		end
	end

	def destroy
		@comment = @document.comments.find(params[:id])
		@comment.destroy
		redirect_to @document, :notice=> 'Comment Deleted'
	end	

	private

		def load_document
			@document = Document.find(params[:document_id])
		end

end
