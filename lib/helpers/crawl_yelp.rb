class CrawlYelp
  def initialize(url)
    @url = url
  end

  def add_yelper
    p = crawl(find_profile_id)
    Yelper.new(name: p.css(".user-profile_info h1").text,
               location: p.css(".user-location").text,
               uid: find_profile_id,
               number_of_reviews: p.css(".review-count span strong").text,
               image_url: p.css(".photo-slideshow_image img").attr("src").text)
  end

  private

  def find_profile_id
    @url.split("userid=").last[0..21]
  end

  def crawl
    profile_id = find_profile_id
    profile_url = "http://www.yelp.com/user_details?userid=" + profile_id
    Nokogiri::HTML(open(profile_url, allow_redirections: :all,
                        "User-Agent" => "Ruby/#{RUBY_VERSION}",
                        "From" => "foo@bar.invalid",
                        "Referer" => "http://www.ruby-lang.org/"))
  end
end
