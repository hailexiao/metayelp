require "open-uri"

class YelpersController < ApplicationController
  before_action :authorize_user, only: [:destroy]
  def index
    if params[:search]
      @yelpers = Yelper.search(params[:search]).order(
        'reviews_count DESC').page(params[:page]).per(6)
    else
      @yelpers = Yelper.order(
        'reviews_count DESC').page(params[:page]).per(6)
    end
  end

  def show
    @yelper = Yelper.find(params[:id])
    @review = Review.new
    @reviews = @yelper.reviews.order(created_at: :desc).page(params[:page]).per(3)
  end

  def new
    @yelper = Yelper.new
  end

  def create
    if params[:yelper][:uid].include?("userid=")
      crawl = CrawlYelp.new(params[:yelper][:uid])
      @yelper = crawl.add_yelper
      current_yelper = crawl.yelper_unique_check
      unless current_yelper.nil?
        redirect_to yelper_path(current_yelper)
        return
      end
    else
      flash[:notice] = "Please submit a valid Profile URL."
      redirect_to new_yelper_path
      return
    end

    if @yelper.save
      flash[:notice] = "Yelper added!"
      redirect_to yelper_path(@yelper.id)
    else
      flash[:error] = @yelper.errors.full_messages.join (". ")
      render :new
    end
  end

  def destroy
    Yelper.find(params[:id]).destroy
    flash[:success] = "Yelper deleted."
    redirect_to yelpers_path
  end

  private

  def yelper_params
    params.require(:yelper).permit(:uid)
  end

  def authorize_user
    unless current_user.admin?
      raise ActionController::RoutingError.new("Not Found")
    end
  end
end
