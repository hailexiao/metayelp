class Yelper < ActiveRecord::Base
  has_many :reviews, dependent: :destroy

  validates :name, presence: true

  validates :location, presence: true

  validates :number_of_reviews, presence: true
  validates :number_of_reviews, numericality: { only_integer: true }

  validates :image_url, presence: true

  validates :uid, presence: true
  validates :uid, uniqueness: { message: " error: Yelper already in system." }

  def self.search(query)
    query_upcase = query.upcase
    where("upper(name) like ?", "%#{query_upcase}%")
  end
end
