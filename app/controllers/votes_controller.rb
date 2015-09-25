class VotesController < ApplicationController
  before_action :set_review

  def create_upvote
    upvote = @review.upvotes.build
    upvote.user_id = current_user.id
    binding.pry
    if upvote.save
      render json: { upvotes_count: @review.upvotes.count }
    else
      render nothing: true, status: 403
    end
  end

  def create_downvote
    downvote = @review.downvotes.build
    downvote.user_id = current_user.id

    if downvote.save
      render json: { downvotes_count: @review.downvotes.count }
    else
      render nothing: true, status: 403
    end
  end

  private

  def set_review
    @review = Review.find(params[:review_id])
  end

end
