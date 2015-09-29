class Upvote < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates :user, presence: true, uniqueness: { scope: :review }
  validates :review, presence: true
end
