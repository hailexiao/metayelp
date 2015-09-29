require 'rails_helper'
require 'pry'

feature 'admin can delete reviews', %{
  As an admin that sees an inappropriate review
  I would like to delete that review
  So the world can be spared from harm
} do

# Acceptance Criteria
#   [] Admin can delete a review from a Yelper's page

  scenario 'admin deletes review' do
    yelper = FactoryGirl.create(:yelper)
    admin = FactoryGirl.create(:user,
                               role: "admin")
    user = FactoryGirl.create(:user)
    review = FactoryGirl.create(:review,
                                yelper: yelper,
                                user: user)

    visit new_user_session_path

    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password

    click_button 'Log in'

    visit yelper_path(yelper)

    page.driver.submit :delete, "/yelpers/#{yelper.id}/reviews/#{review.id}", {}

    expect(page).to_not have_content(review.body)


  end


end
