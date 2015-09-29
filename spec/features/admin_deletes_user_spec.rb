require 'rails_helper'

feature 'admin can delete users', %{
  As an admin that dislikes a user
  I would like to delete them
  So they no longer exist in the database
} do

  # Acceptance Criteria
  # [*] An admin can delete a user

  scenario 'admin deletes a user' do
    admin = FactoryGirl.create(:user, role: "admin")
    review = FactoryGirl.create(:review)
    review_body = review.body
    user = review.user
    yelper = review.yelper

    10.times do
      FactoryGirl.create(:upvote, review: review)
    end

    visit new_user_session_path

    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password

    click_button 'Log in'

    visit user_path(user)

    click_button 'Delete User'

    expect(page).to have_content('User deleted.')

    visit yelper_path(yelper)

    expect(page).to_not have_content(review_body)
    expect(page).to_not have_content('10')
  end

  scenario 'admin tries to delete another admin' do
    admin1 = FactoryGirl.create(:user, role: "admin")
    admin2 = FactoryGirl.create(:user, role: "admin")

    visit new_user_session_path

    fill_in 'Email', with: admin1.email
    fill_in 'Password', with: admin1.password

    click_button 'Log in'

    visit user_path(admin2)

    click_button 'Delete User'

    expect(page).to have_content("is an admin")
  end

end
