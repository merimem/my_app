class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :article
	validates :content, presence: true, length: {minimum: 3, maximum: 50}

end