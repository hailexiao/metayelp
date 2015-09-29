class Upvote < ActiveRecord::Base
  belongs_to :user
  belongs_to :review

  validates :user, presence: true
  validates :review, presence: true

  validates :user, uniqueness: { scope: :review }
end
