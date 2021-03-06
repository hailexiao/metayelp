require 'rails_helper'

feature 'add a review', %{
  As a signed in user
  I want to review yelpers
  So others will know if they are good at yelping.
} do
  # Acceptance Criteria
  # [*] An unauthenticated user cannot add a review
  # [] An authenticated user can create a new review
  # [] The new review appears on the yelper's show page
  scenario 'an unauthenticated user tries to add a review' do
    yelper = FactoryGirl.create(:yelper)

    visit yelper_path(yelper)
    find('#review_rating_2').set(true)
    fill_in "review[body]", with: "So elite."

    click_button 'Submit Review'

    expect(page).to have_content("You need to sign in or
      sign up before continuing.")
  end

  scenario 'an authenticated user enters a blank review' do
    yelper = FactoryGirl.create(:yelper)
    user = FactoryGirl.create(:user)

    sign_in_as(user)

    visit yelper_path(yelper)

    click_button 'Submit Review'

    expect(page).to have_content("can't be blank")
  end

  scenario 'an authenticated user submits a properly formatted review' do
    yelper = FactoryGirl.create(:yelper)
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    sign_in_as(user)

    visit yelper_path(yelper)
    find('#review_rating_5').set(true)
    fill_in "review[body]", with: "This reviewer is so totally elite and
                                   stuff. It's great."

    click_button 'Submit Review'

    expect(page).to have_content("Review added!")
    expect(page).to have_css(".fi-star", count: 5)
    expect(page).to have_content("This reviewer is so totally elite and
                                  stuff. It's great.")
  end
end
