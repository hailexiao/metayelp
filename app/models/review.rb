class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :yelper

  validates :rating, presence: true
  validates :rating, numericality: { only_integer: true }
  validates :rating, inclusion: { in: 1..5 }

  validates :body, presence: true
  validates :body, length: { minimum: 25, maximum: 5000 }

  validates :user, presence: true
  
  validates :yelper, presence: true
end
