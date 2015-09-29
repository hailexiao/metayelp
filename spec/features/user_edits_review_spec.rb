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
  scenario "an unauthenticated user wants to edit a review" do
    review = FactoryGirl.create(:review)
    yelper = review.yelper

    visit yelper_path(yelper)


    expect(page).not_to have_content("Edit Review")
  end
  scenario "a logged in user tries to edit their review" do
    review = FactoryGirl.create(:review)
    yelper = review.yelper
    user = review.user

    sign_in_as(user)

    visit yelper_path(yelper)

    click_button("Edit Review")
    fill_in "Body", with: "My feelings on this yelper have soured.
                          His reviews suck."
    fill_in "Rating", with: 1
    click_button("Submit Review")

    expect(page).to have_content(yelper.name)
    expect(page).to have_content("My feelings on this yelper have soured.
                          His reviews suck.")
  end

  scenario "a logged in user tries to edit another user's review" do
    review = FactoryGirl.create(:review)
    review_two = FactoryGirl.create(:review)
    yelper = review_two.yelper
    user = review.user

    sign_in_as(user)

    visit yelper_review_path(yelper_id: yelper.id, id: review_two.id)

    fill_in "Body", with: "My feelings on this yelper have soured.
                          His reviews suck."
    fill_in "Rating", with: 1
    click_button("Submit Review")

    expect(page).to have_content("You can only edit your own reviews")
  end
end
