class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_yelper_and_review, only: [:show, :update]

  def create
    @review = Review.new(review_params)
    @yelper = Yelper.find(params[:yelper_id])
    @review.yelper = @yelper
    @review.user = current_user

    if @review.save
      flash[:notice] = 'Review added!'
      redirect_to yelper_path(@yelper)
    else
      flash[:errors] = @review.errors.full_messages.join(". ")
      redirect_to yelper_path(@yelper)
    end
  end


  def show
    @yelper
    @review
  end

  def update
    @yelper
    @review
    @review.update(body: review_params[:body], rating: review_params[:rating])
    if @review.save
      redirect_to yelper_path(@yelper, anchor: "#{@review.id}")
    else
      flash[:errors] = @review.errors.full_messages.join(". ")
      render :show
    end
  end

  def destroy
    @review = Review.find(params[:id])
    authorize_user(@review)
    @yelper = @review.yelper
    @review.destroy
    flash[:success] = 'Review deleted.'
    redirect_to yelper_path(@yelper)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :body)
  end

  def authorize_user(review)
    unless current_user == review.user || current_user.admin?
      raise ActionController::RoutingError.new("Not Found")
    end
  end

  def set_yelper_and_review
    @yelper = Yelper.find(params[:yelper_id])
    @review = Review.find(params[:id])
  end
end
