class CrawlYelp
  def initialize(url)
    @url = url
  end

  def add_yelper
    page = crawl(find_profile_id)
    Yelper.new(name: page.css(".user-profile_info h1").text,
               location: page.css(".user-location").text,
               uid: find_profile_id,
               number_of_reviews: page.css(".review-count span strong").text,
               image_url: page.css(".photo-slideshow_image img").attr("src").text)
  end

  private

  def find_profile_id
    @url.split("userid=").last[0..21]
  end

  def crawl(id)
    profile_id = find_profile_id
    profile_url = "http://www.yelp.com/user_details?userid=" + profile_id
    Nokogiri::HTML(open(profile_url, allow_redirections: :all,
                        "User-Agent" => "Ruby/#{RUBY_VERSION}",
                        "From" => "foo@bar.invalid",
                        "Referer" => "http://www.ruby-lang.org/"))
  end
end
