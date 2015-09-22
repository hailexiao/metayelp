class Yelper < ActiveRecord::Base
  has_many :reviews

  validates :name, presence: true

  validates :location, presence: true

  validates :number_of_reviews, presence: true
  validates :number_of_reviews, numericality: { only_integer: true}

  validates :image_url, presence: true

  validates :uid, presence: true
end
