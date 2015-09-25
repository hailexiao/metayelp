class Downvote < ActiveRecord::Base
  validates :user_id, presence: true
  validates :review_id, presence: true

    validates_uniqueness_of :user_id, scope: :review_id
end
