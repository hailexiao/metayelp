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

    sign_in_as(admin)
    visit admin_users_path

    expect(page).to have_content(user.first_name)
  end

  scenario 'authenticated non-admin visits users index' do
    user = FactoryGirl.create(:user)

    sign_in_as(user)

    visit admin_users_path

    expect(page).to have_content("You don't have access to this section.")
  end

  scenario 'random person visits users index' do
    visit admin_users_path

    expect(page).to have_content("You don't have access to this section.")
  end
end
