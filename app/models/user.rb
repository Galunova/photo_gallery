class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
	has_many :photos, dependent: :destroy
	has_many :comments, dependent: :destroy

  def role?(r)
	  role.include? r.to_s
	end
end
