class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :yelper

  validates_presence_of :rating
  validates_numericality_of :rating
  validates_inclusion_of :rating, in: 1..5

  validates_presence_of :body
  validates_length_of :body, minimum: 25, maximum: 5000

  validates_presence_of :user
  validates_presence_of :yelper
end
