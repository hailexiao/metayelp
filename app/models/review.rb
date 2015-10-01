class Review < ActiveRecord::Base
  RATINGS = ["1", "2", "3", "4", "5"]

  belongs_to :user
  belongs_to :yelper
  has_many :upvotes, dependent: :destroy
  has_many :downvotes, dependent: :destroy

  validates :rating, presence: true
  validates :rating, numericality: { only_integer: true }
  validates :rating, inclusion: { in: RATINGS }

  validates :body, presence: true
  validates :body, length: { minimum: 25, maximum: 5000 }

  validates :user, presence: true

  validates :yelper, presence: true
end
