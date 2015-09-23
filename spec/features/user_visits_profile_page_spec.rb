require 'rails_helper'

feature 'user has a profile page', %{
  As a reviewer of Yelpers
  I want to view my own profile
  So I can see how I appear to other users
} do

  # Acceptance criteria
  # [] When an authenticated user logs in they can navigate to profile page

  scenario 'user logs in and visits profile' do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    expect(page).to have_content('Profile')
  end

end
