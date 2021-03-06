require 'rails_helper'

feature 'search for a yelper', %{
  As a reviewer of Yelpers
  I want to search for a Yelper
  So I can review them
} do
  # Acceptance criteria
  # [*] When a user searches for a Yelper by name, it should return
  #  a list of Yelpers who match that name.
  # [*] When a user searches for a Yelper and there are no matches,
  #  an alert prompts the user to add that Yelper.

  scenario 'user searches for a Yelper by name' do
    yelpers = []
    5.times do
      new_yelper = FactoryGirl.create(:yelper)
      yelpers << new_yelper
    end

    visit yelpers_path
    fill_in 'search', with: yelpers[3].name
    click_button 'Search'

    expect(page).to have_content(yelpers[3].location)
  end

  scenario 'search returns no matches' do
    visit yelpers_path
    fill_in 'search', with: "Bob"
    click_button 'Search'

    expect(page).to have_link("Would you like to add one?",
                              href: new_yelper_path)
  end
end
