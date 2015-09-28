require "open-uri"

class YelpersController < ApplicationController
  def index
    if params[:search]
      @yelpers = Yelper.search(params[:search]).order(
        'number_of_reviews DESC').page(params[:page]).per(6)
    else
      @yelpers = Yelper.order(
        'number_of_reviews DESC').page(params[:page]).per(6)
    end
  end

  def show
    @yelper = Yelper.find(params[:id])
    @review = Review.new
  end

  def new
    @yelper = Yelper.new
  end

  def create
    if params[:yelper][:uid].include?("userid=")
      crawl = CrawlYelp.new(params[:yelper][:uid])
      @yelper = crawl.add_yelper

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

  private

  def yelper_params
    params.require(:yelper).permit(:uid)
  end
end
