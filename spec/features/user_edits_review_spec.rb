require 'rails_helper'

feature 'edit a review', %{
  As a signed in user
  I want to edit my reviews of yelpers
  if I change my opinion about their yelping.
} do
  # Acceptance Criteria
  # [] An unauthenticated user cannot edit a review
  # [] An authenticated user can edit their reviews
  # [] An authenticated user cannot edit other users reviews
  scenario 'an unauthenticated user tries to add a review' do
    review = FactoryGirl.create(:review)
    yelper = review.yelper

    visit yelper_path(yelper)
    click_button("Edit Review")

    expect(page).to have_content("You need to sign in or
      sign up before continuing.")
  end
end
