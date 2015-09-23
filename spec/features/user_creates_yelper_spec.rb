require "rails_helper"
require "open-uri"

feature "user creates yelper", %{
  As an authenticated user
  I would like to add new Yelpers
  So I can review them
} do
  scenario "successfully submits yelper" do
    link_url = "http://www.yelp.com/user_details?userid=grEg3_xe95VezJytyov7cQ"
    visit new_yelper_path
    fill_in "yelper[uid]", with: link_url
    click_button "Submit"

    doc = Nokogiri::HTML(open(link_url,
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
end
