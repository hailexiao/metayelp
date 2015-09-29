class VotesController < ApplicationController
  before_action :set_review

  def create_upvote
    upvote = @review.upvotes.build
    upvote.user_id = current_user.try(:id)
    if upvote.save
      down_vote = @review.downvotes.find_by(user_id: current_user.id)
      unless down_vote.nil?
        Downvote.destroy(down_vote.id)
      end
      render json: { upvotesCount: @review.upvotes.count,
                     downvotesCount: @review.downvotes.count }
    else
      render nothing: true, status: 403
    end
  end

  def create_downvote
    downvote = @review.downvotes.build
    downvote.user_id = current_user.id

    if downvote.save
      up_vote = @review.upvotes.find_by(user_id: current_user.id)
      unless up_vote.nil?
        Upvote.destroy(up_vote.id)
      end
      render json: { downvotesCount: @review.downvotes.count,
                     upvotesCount: @review.upvotes.count }
    else
      render nothing: true, status: 403
    end
  end

  private

  def set_review
    @review = Review.find(params[:review_id])
  end
end
