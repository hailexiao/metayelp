require 'rails_helper'

feature 'user has a profile page', %{
  As a reviewer of Yelpers
  I want to view my own profile
  So I can see how I appear to other users
} do

  # Acceptance criteria
  # [] When an authenticated user logs in they can navigate to profile page. Beep beep.

  scenario 'user logs in and visits profile' do
    user = FactoryGirl.create(:user)

    sign_in_as(user)

    expect(page).to have_content('Profile')

    visit user_path(user)

    expect(page).to have_content(user.first_name)
    expect(page).to have_content(user.last_name[0].upcase)
  end

end
