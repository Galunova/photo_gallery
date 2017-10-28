class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :photo
	validates :text, :user_id, :photo_id, presence: true
end
