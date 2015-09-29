class User < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :upvotes
  has_many :downvotes

  mount_uploader :profile_photo, ProfilePhotoUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    role == "admin"
  end
end
