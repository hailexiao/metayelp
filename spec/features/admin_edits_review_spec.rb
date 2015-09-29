require 'rails_helper'

feature 'admin edit a review', %{
  As a signed in Admin I want to be able to edit reviews
  because people say crazy shit.
} do
  # Acceptance Criteria
  # [] An unauthenticated user cannot edit a review
  # [] An authenticated user can edit their reviews
  # [] An authenticated user cannot edit other users reviews
  scenario "an unauthenticated user wants to edit a review" do
    review = FactoryGirl.create(:review)
    yelper = review.yelper
    admin = FactoryGirl.create(:user, role: "admin")

    sign_in_as(admin)
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
end
