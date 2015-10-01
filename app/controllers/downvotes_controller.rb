class DownvotesController < ApplicationController
  before_action :set_review

  def create
    downvote = @review.downvotes.new
    downvote.user = current_user
    if downvote.save
      @review.upvotes.where(user: current_user).destroy_all
      VoteMailer.new_downvote(@review).deliver_later
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
