require 'rails_helper'

feature 'delete user account', %{
  As a no longer interested reviewer
  I want to delete my account
  So that I am no longer associated with the app
} do

  scenario 'user logs in and deletes account' do

    user = FactoryGirl.create(:user)

    sign_in_as(user)

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content('Sign Out')

    visit edit_user_registration_path
    click_button 'Delete my account'


    expect(page).to have_content
    'Bye! Your account has been successfully cancelled.'
  end
end
