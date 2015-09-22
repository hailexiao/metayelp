require 'open-uri'

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
      doc = crawl(yelper_params[:uid])

      params[:yelper][:name] = doc.css(".user-profile_info h1").text

      params[:yelper][:location] = doc.css(".user-location").text

      params[:yelper][:image_url] = doc.css(
        ".photo-slideshow_image img").attr('src').text

      params[:yelper][:number_of_reviews] = doc.css(
        ".review-count span strong").text

      params[:yelper][:uid] = find_profile_id(yelper_params[:uid])

      @yelper = Yelper.new(yelper_params)

      if @yelper.save
        flash[:notice] = "Yelper added!"
        redirect_to yelper_path(@yelper.id)
      else
        flash[:notice] = "Please submit a valid Profile URL."
        render :new
      end
    else
        flash[:notice] = "Please submit a valid Profile URL."
        redirect_to new_yelper_path
    end
  end

  private

  def crawl(id)
    profile_id = find_profile_id(id)
    profile_url = "http://www.yelp.com/user_details?userid=" + profile_id
    doc = Nokogiri::HTML(open(profile_url,
          "User-Agent" => "Ruby/#{RUBY_VERSION}",
          "From" => "foo@bar.invalid",
          "Referer" => "http://www.ruby-lang.org/"))
  end

  def find_profile_id(id)
    id.split("userid=").last[0..21]
  end


  def yelper_params
    params.require(:yelper).permit(:name, :location, :image_url,
      :number_of_reviews, :uid)
  end
end
