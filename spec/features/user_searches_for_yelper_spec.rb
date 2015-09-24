require 'rails_helper'

feature 'search for a yelper', %{
  As a reviewer of Yelpers
  I want to search for a Yelper
  So I can review them
} do

  # Acceptance criteria
  # [] When a user searches for a Yelper by name, it should return
  #  a list of Yelpers who match that name.

  scenario 'user searches for a Yelper by name' do
    yelpers = []
    10.times do
      yelpers << FactoryGirl.create(:yelper)
    end

    visit yelpers_path
    fill_in 'search', with: yelpers[2].name
    click_button 'Search'

    expect(page).to have_content(yelpers[2].location)
  end
end
