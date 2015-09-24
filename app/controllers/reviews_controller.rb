class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    @yelper = Yelper.find(params[:yelper_id])
    @review.yelper = @yelper
  end

  private

  def review_params
    parmas.require(:review).permit(:rating, :body)
  end
end
