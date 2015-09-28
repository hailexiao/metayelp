class Upvote < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates :user, presence: true
  validates :review, presence: true

  validates_uniqueness_of :user_id, scope: :review_id
end
