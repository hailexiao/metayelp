require 'rails_helper'

feature 'add a review', %{
  As a signed in user
  I want to review yelpers
  So others will know if they are good
  at yelping.
} do
  # Acceptance Criteria
  # [*] An unauthenticated user cannot add a review
  # [] An authenticated user can create a new review
  # [] The new review appears on the yelper's show page
  scenario 'an unauthenticated user tries to add a review' do
    yelper = FactoryGirl.create(:yelper)

    visit yelper_path(yelper)
    fill_in "Rating", with: 5
    fill_in "Body", with: "So elite."

    click_button 'Submit Review'

    expect(page).to have_content("You need to sign in or
                                  sign up before continuing.")
  end

  scenario 'an authenticated user enters a blank review' do
    yelper = FactoryGirl.create(:yelper)
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    visit yelper_path(yelper)

    click_button 'Submit Review'

    expect(page).to have_content("Rating is not a number. Rating is not included
                                  in the list. Body can't be blank.
                                  Body is too short (minimum is 25 characters)")
  end

  scenario 'an authenticated user submits a properly formatted review' do
    yelper = FactoryGirl.create(:yelper)
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    visit yelper_path(yelper)
    fill_in "Rating", with: 5
    fill_in "Body", with: "This reviewer is so totally elite and
                           stuff. It's great."

    click_button 'Submit Review'

    expect(page).to have_content("Review added!")
    expect(page).to have_content(5)
    expect(page).to have_content("This reviewer is so totally elite and
                                  stuff. It's great.")
  end
end
