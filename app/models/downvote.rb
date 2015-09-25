class Downvote < ActiveRecord::Base
  validates :user, presence: true
  validates :review, presence: true
end
