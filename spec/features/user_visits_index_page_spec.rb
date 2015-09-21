require 'rails_helper'

feature 'user visits main page', %Q{
  As a prospective reviewer
  I want to view a list of Yelpers
  So that I can select a Yelper to review
} do

  # Acceptance Criteria
  # [] When a user visits the main page, they should see a list of Yelpers

  scenario 'visit main page' do
    yelper1 = FactoryGirl.create(:yelper)
    yelper2 = FactoryGirl.create(:yelper)

    visit yelpers_path

    expect(page).to have_content(yelper1.name)
    expect(page).to have_content(yelper2.name)
    expect(page).to have_content(yelper1.location)
    expect(page).to have_content(yelper2.location)

  end

end
