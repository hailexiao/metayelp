require 'rails_helper'

feature 'edit user profile', %{
  As a signed up user
  I want to edit my profile information
  So that my profile is up to date
} do

  # Acceptance criteria
  # [*] If user is not signed in, the "edit" option should not appear on the me-
  #       nu bar
  # [*] If user is not signed in and manually enters the "edit" URL, user is
  #   redirected to login page
  # [*] If user is signed in, they should see the edit page
  # [*] If user updates with invalid information, they should be redirected to
  #   edit page with error message
  # [*] If user updates with valid information, the information should be saved
  #     to the database

  scenario 'user is not signed in' do
    visit root_path
    first_menu_item = first(:css, '.top-bar-section .right li a')
    expect(first_menu_item.text).to have_content 'Sign Up'
  end

  scenario 'user manually enters edit URL' do
    visit edit_user_registration_path
    expect(page).to have_content 'You need to sign in or sign up'
  end

  scenario 'signed in user inputs invalid password' do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
    second_menu_item = all(:css, '.top-bar-section .right li a')[1]
    expect(second_menu_item.text).to have_content 'Edit My Account'

    click_link 'Edit My Account'

    fill_in 'Password', with: 'bbbb'
    fill_in 'Password confirmation', with: 'bbbb'
    fill_in 'Current password', with: user.password
    click_button 'Update'

    expect(page).to have_content 'Password is too short'
  end

  scenario 'signed in user inputs incorrect password confirmation' do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
    second_menu_item = all(:css, '.top-bar-section .right li a')[1]
    expect(second_menu_item.text).to have_content 'Edit My Account'
    click_link 'Edit My Account'
    fill_in 'Password', with: 'bbbb'
    fill_in 'Password confirmation', with: 'xxxx'
    fill_in 'Current password', with: user.password
    click_button 'Update'

    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  scenario 'signed in user inputs proper information' do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_button 'Log in'

    expect(page).to have_content('Signed in successfully')
    second_menu_item = all(:css, '.top-bar-section .right li a')[1]
    expect(second_menu_item.text).to have_content 'Edit My Account'

    click_link 'Edit My Account'
    fill_in 'Email', with: 'thisismynewemail@email.com'
    fill_in 'First name', with: 'Thisismynewfirstname'
    fill_in 'Last name', with: 'Thisismynewlastname'
    fill_in 'Password', with: 'Thisismynewpassword'
    fill_in 'Password confirmation', with: 'Thisismynewpassword'
    fill_in 'Current password', with: user.password
    click_button 'Update'

    expect(page).to have_content('Your account has been updated successfully.')
    click_link 'Edit My Account'

    expect(find_field('Email').value).to eq 'thisismynewemail@email.com'
    expect(find_field('First name').value).to eq 'Thisismynewfirstname'
    expect(find_field('Last name').value).to eq 'Thisismynewlastname'

  end
end
