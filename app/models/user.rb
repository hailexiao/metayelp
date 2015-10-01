class User < ActiveRecord::Base

  IMAGE_SOURCES = [
    "http://www.placebear.com/250/250",
    "http://placekitten.com/g/250/250",
    "http://placecreature.com/panda/250/250",
    "http://placecreature.com/kitten/250/250",
    "http://placecreature.com/bear/250/250"
  ]

  has_many :reviews, dependent: :destroy
  has_many :upvotes, dependent: :destroy
  has_many :downvotes, dependent: :destroy

  mount_uploader :profile_photo, ProfilePhotoUploader

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    role == "admin"
  end

  def display_image
    if profile_photo
      profile_photo
    end
    IMAGE_SOURCES.sample
  end
end
