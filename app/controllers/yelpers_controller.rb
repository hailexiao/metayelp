require "open-uri"

class YelpersController < ApplicationController
  def index
    @yelpers = Yelper.all
  end

  def show
    @yelper = Yelper.find(params[:id])
  end

  def new
    @yelper = Yelper.new
  end

  def create
    if params[:yelper][:uid].include?("userid=")

      doc = crawl(params[:yelper][:uid])
      add_params(params, doc)

      @yelper = Yelper.new(yelper_params)
    else
      flash[:notice] = "Please submit a valid Profile URL."
      redirect_to new_yelper_path && return
    end

    if @yelper.save
      flash[:notice] = "Yelper added!"
      redirect_to yelper_path(@yelper.id)
    else
      flash[:notice] = "Unable to retrieve profile page."
      render :new
    end
  end

  private

  def crawl(id)
    profile_id = find_profile_id(id)
    profile_url = "http://www.yelp.com/user_details?userid=" + profile_id
    Nokogiri::HTML(open(profile_url,
                   "User-Agent" => "Ruby/#{RUBY_VERSION}",
                   "From" => "foo@bar.invalid",
                   "Referer" => "http://www.ruby-lang.org/"))
end

  def find_profile_id(id)
    id.split("userid=").last[0..21]
  end

  def add_params(p, doc)
    p[:yelper][:name] = doc.css(".user-profile_info h1").text
    p[:yelper][:location] = doc.css(".user-location").text
    p[:yelper][:uid] = find_profile_id(yelper_params[:uid])
    p[:yelper][:image_url] = doc.css(".photo-slideshow_image img").
                                     attr("src").text
    p[:yelper][:number_of_reviews] = doc.css(".review-count span strong").text
    p
  end

  def yelper_params
    params.require(:yelper).permit(:name, :location, :image_url,
                                   :number_of_reviews, :uid)
  end
end
