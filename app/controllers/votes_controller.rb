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

      respond_to do |format|
        format.html do
          binding.pry
          redirect_to yelper_path(@review.yelper.id)
        end
        format.json do
          render json: { upvotes_count: @review.upvotes.count,
                         downvotes_count: @review.downvotes.count }
        end
      end
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

      respond_to do |format|
        format.html do
          redirect_to yelper_path(@review.yelper.id)
        end
        format.json do
          render json: { downvotes_count: @review.downvotes.count,
                         upvotes_count: @review.upvotes.count }
        end
      end
    else
      render nothing: true, status: 403
    end
  end

  private

  def set_review
    @review = Review.find(params[:review_id])
  end

end
