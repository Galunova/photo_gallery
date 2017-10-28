class Photo < ApplicationRecord
	mount_uploader :image, PhotoUploader
	belongs_to :user
	has_many :comments, dependent: :destroy
	validates :user_id, :title, :image, presence: true

end
