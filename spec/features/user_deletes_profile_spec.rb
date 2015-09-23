require 'rails_helper'

feature 'delete user account', %{
  As a no longer interested reviewer
  I want to delete my account
  So that I am no longer associated with the app
} do

  before(:all) do
    Capybara.current_driver = :selenium
  end

  scenario 'user logs in and deletes account' do

    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
    expect(page).to have_content('Sign Out')

    visit edit_user_registration_path
    click_button 'Cancel my account'

    alert = page.driver.browser.switch_to.alert
    expect(alert.text).to eq('Are you sure?')
    alert.accept

    expect(page).to have_content
    'Bye! Your account has been successfully cancelled.'
  end

  after(:all) do
    Capybara.use_default_driver
  end

end
