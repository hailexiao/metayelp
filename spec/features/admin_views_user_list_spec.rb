require 'rails_helper'

feature 'user signs out', %{
  As an admin
  I want to view a list of the users on my site
  So I can contemplate the power I have over them
} do

  # Acceptance Criteria
  # [] An admin can view a listing of all registered users
  # [] A non-admin cannot view a listing of all registered users

  scenario 'admin visits users index' do
    admin = FactoryGirl.create(:user, role: "admin")
    user = FactoryGirl.create(:user)


    visit new_user_session_path

    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password

    click_button 'Log in'

    visit admin_users_path
  
    expect(page).to have_content(user.first_name)
  end

  scenario 'non-admin visits users index' do

  end
end
