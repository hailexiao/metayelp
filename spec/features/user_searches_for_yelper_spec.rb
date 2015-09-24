require 'rails_helper'

feature 'search for a yelper', %{
  As a reviewer of Yelpers
  I want to search for a Yelper
  So I can review them
} do

  # Acceptance criteria
  # [*] When a user searches for a Yelper by name, it should return
  #  a list of Yelpers who match that name.
  # [] When a user searches for Yelpers by location, it should return
  #  a list of Yelpers at that location.
  # [] When a user searches for a Yelper and there are no matches,
  #  an alert prompts the user to add that Yelper.

  scenario 'user searches for a Yelper by name' do
    yelpers = []
    10.times do
      yelpers << FactoryGirl.create(:yelper)
    end

    visit yelpers_path
    select('Name', from: 'By: ')
    fill_in 'search', with: yelpers[2].name
    click_button 'Search'

    expect(page).to have_content(yelpers[2].location)
  end

  scenario 'user searches for Yelpers by location' do
    yelpers = []
    10.times do
      yelpers << FactoryGirl.create(:yelper)
    end

    visit yelpers_path
    select('Location', from: 'By: ')
    fill_in 'search', with: yelpers[2].location

  end

  scenario 'search returns no matches' do
    visit yelpers_path
    fill_in 'search', with: "Bob"
    click_button 'Search'

    expect(page).to have_link("Would you like to add one?",
      href: new_yelper_path)
  end
end
