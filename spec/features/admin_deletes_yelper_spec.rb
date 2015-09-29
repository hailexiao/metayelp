require 'rails_helper'

feature 'admin can delete yelper', %{
  As an admin facing a lawsuit
  I would like to delete a yelper
  So they will drop the charges
} do

  # Acceptance Criteria
  # [*] An admin can delete a yelper

  scenario 'admin deletes a yelper' do
    admin = FactoryGirl.create(:user, role: "admin")
    yelper = FactoryGirl.create(:yelper)

    visit new_user_session_path

    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password

    click_button 'Log in'

    visit yelper_path(yelper)

    click_button 'Delete Yelper'

    expect(page).to have_content('Yelper deleted.')
  end
end
