require 'rails_helper'

feature 'user photo profile', %Q{
  As a reviewer of Yelpers
  I want to upload a profile photo
  So that I can let others see how cool I am
} do

  # Acceptance Criteria:
  # [] If user uploads a valid profile picture, it is present on their
  #   profile page
  # [] If user uploads an invalid picture, they are redirected back to
  #   the new user or edit profile page

  scenario 'provide valid photo during registration' do
    visit new_user_registration_path

    fill_in 'First name', with: 'Bob'
    fill_in 'Last name', with: 'Loblaw'
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    image_path = Rails.root + 'spec/fixtures/files/basset_hound.jpg'
    attach_file 'Profile photo', image_path

    click_button 'Sign up'
    click_link 'Profile'

    expect(page).to have_css('img[alt*="profile image"]')
  end

  scenario 'provide invalid registration information' do
    visit new_user_registration_path

    fill_in 'First name', with: 'Bobby'
    fill_in 'Last name', with: 'Loblaw'
    fill_in 'Email', with: 'john2@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    image_path = Rails.root + 'spec/fixtures/files/fake_pic.txt'
    attach_file 'Profile photo', image_path

    click_button 'Sign up'

    expect(page).to have_content("You are not allowed to upload")
  end
end
