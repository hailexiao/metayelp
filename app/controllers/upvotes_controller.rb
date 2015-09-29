class UpvotesController < ApplicationController
  before_action :set_review

  def create
    upvote = @review.upvotes.new
    upvote.user = current_user
    if upvote.save
      @review.downvotes.where(user: current_user).destroy_all
      render json: { upvotesCount: @review.upvotes.count,
                     downvotesCount: @review.downvotes.count }
    else
      render nothing: true, status: 403
    end
  end

  private

  def set_review
    @review = Review.find(params[:review_id])
  end
end
