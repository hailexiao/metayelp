class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @review = Review.new(review_params)
    @yelper = Yelper.find(params[:yelper_id])
    @review.yelper = @yelper

    if @review.save
      flash[:notice] = 'Review added!'
      redirect_to yelper_path(@yelper)
    else
      redirect_to yelper_path(@yelper)
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end
