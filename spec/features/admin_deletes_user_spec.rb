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
    user = FactoryGirl.create(:user

    visit new_user_session_path

    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password

    click_button 'Log in'

    visit admin_user_path(user)

    click_link 'Delete user'

    expect(page).to not_have_link(user.id)
  end

end
