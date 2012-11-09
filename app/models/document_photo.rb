class DocumentPhoto < ActiveRecord::Base
	belongs_to :document
	has_attached_file :photo, 
                    :styles => { :small => '80x80#', :thumb => '150x150#' ,:large=> "600X600>" },
                    :storage => :s3,
                    :s3_credentials => "#{Rails.root}/config/s3.yml",
                    :path => "uploads/:attachment/:id/:style.:extension"
  
 	validates_attachment_size :photo, :less_than => 5.megabytes
 	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/gif', 'image/png']
 	validates_attachment_presence :photo

end
