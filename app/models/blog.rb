class Blog < ActiveRecord::Base
	belongs_to :user
	has_many :comments, as: :commentable
	accepts_nested_attributes_for :comments
	# validates :user, presence: true
	# validates :user_id, presence: {message: "Field User cannot be blank."}
	validates :post, presence: {message: "Post cannot be blank"}
	validates :summary, presence: {message: "Summary cannot be blank"}
	validates :post, length: {minimum: 50, message: "Post must be longer than 50 characters"}
	validates :summary, length: {minimum: 10, maximum: 40, 
																message: "Summary length must be between 10 and 40 characters"}

	#when posting via api, no login required. This sets user_id field so that it is not null
	before_save :add_user_id

private
	def add_user_id
		self.user_id ||= 1
	end
end