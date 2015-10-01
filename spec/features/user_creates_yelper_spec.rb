require "rails_helper"
require "open-uri"

feature "user creates yelper", %{
  As an authenticated user
  I would like to add new Yelpers
  So I can review them and stuff
} do
  scenario "successfully submits yelper" do
    link_url = "http://www.yelp.com/user_details?userid=grEg3_xe95VezJytyov7cQ"
    visit new_yelper_path
    fill_in "yelper[uid]", with: link_url
    click_button 'Submit'

    doc = Nokogiri::HTML(open(link_url, allow_redirections: :all,
                              "User-Agent" => "Ruby/#{RUBY_VERSION}",
                              "From" => "foo@bar.invalid",
                              "Referer" => "http://www.ruby-lang.org/"))

    location = doc.css(".user-location").text
    name = doc.css(".user-profile_info h1").text
    review_count = doc.css(".review-count span strong").text

    expect(page).to have_content(location)
    expect(page).to have_content(name)
    expect(page).to have_content(review_count)
  end

  scenario "yelper submit fails" do
    visit new_yelper_path
    fill_in "yelper[uid]", with: "http://www.google.com"
    click_button "Submit"

    expect(page).to have_content("Please submit a valid Profile URL.")
  end

  scenario "user adds yelper which already exists" do

    crawl = CrawlYelp.new("grEg3_xe95VezJytyov7cQ")
    yelper = crawl.add_yelper
    user = FactoryGirl.create(:user)
    yelper.reviews << Review.new(rating: 5, body: "exactlytwentyfivecharacters",
                                 user_id: user.id, yelper_id: 1)
    yelper.save

    url = "https://www.yelp.com/user_details?userid="

    visit new_yelper_path
    fill_in "yelper[uid]", with: url + yelper.uid
    click_button "Submit"

    expect(page).to have_content(yelper.reviews.first.body)
  end
end
