require 'rails_helper'

feature 'add a review', %{
  As a signed in user
  I want to review yelpers
  So others will know if they are good
  at yelping.
} do
  #Acceptance Criteria
  # [] An unauthenticated user cannot add a review
  # [] An authenticated user can create a new review
  # [] The new review appears on the yelper's profile
  scenario 'an unauthenticated user tries to add a review' do

    yelper = FactoryGirl.create(:yelper)

    visit yelper_path(yelper)
    click_on('id-of-four')
    fill_in "Review", with: "So elite."

    click_button 'Submit Review'

    expect(page).to have_content("You need to sign in or sign up before continuing.")
  end
end
