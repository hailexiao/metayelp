require 'rails_helper'

feature 'user can vote on reviews', %{
  As a reviewer of Yelpers
  I want to vote on reviews of yelpers
  So I can let people know which yelper reviewers are
  the best at leaving yelp reviews.
} do
  # Acceptance criteria
  # [*] When an unauthenticated user tries to vote, they cannot.
  # [*] When an authenticated user upvotes, the review's upvotes goes up 1.
  # [*] When an authenticated user downvotes, the review's downvotes goes down 1
  # [*] Users can only vote once per review.
  scenario 'an unauthenticated user tries to vote', js: true do
    review = FactoryGirl.create(:review)
    yelper = review.yelper

    10.times do
      FactoryGirl.create(:upvote, review_id: review.id)
    end

    visit yelper_path(yelper)

    expect(page).to have_content '10'

    click_link("up-vote")

    expect(page).to have_content '10'
  end

  scenario "signed in user upvotes,review's upvotes goes up 1", js: true do
    review = FactoryGirl.create(:review)
    yelper = review.yelper
    user = review.user

    10.times do
      FactoryGirl.create(:upvote, review_id: review.id)
    end

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit yelper_path(yelper)

    click_link("up-vote")
    expect(page).to have_content("11")
  end

  scenario "signed in user downvotes, review's downvotes go down 1", js: true do
    review = FactoryGirl.create(:review)
    yelper = review.yelper
    user = review.user

    10.times do
      FactoryGirl.create(:upvote, review_id: review.id)
    end

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit yelper_path(yelper)

    click_link("down-vote")
    expect(page).to have_content("1")
  end

  scenario "signed in user tries to vote twice on the same review", js: true do
    review = FactoryGirl.create(:review)
    yelper = review.yelper
    user = review.user

    10.times do
      FactoryGirl.create(:upvote, review_id: review.id)
    end

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit yelper_path(yelper)

    click_link("down-vote")
    expect(page).to have_content("1")
    click_link("down-vote")
    expect(page).to have_content("1")
  end

  scenario "an authenticated upvotes then downvotes", js: true do
    review = FactoryGirl.create(:review)
    yelper = review.yelper
    user = review.user

    10.times do
      FactoryGirl.create(:upvote, review_id: review.id)
    end

    visit new_user_session_path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    visit yelper_path(yelper)

    click_link("up-vote")
    expect(page).to have_content("11")
    click_link("down-vote")
    expect(page).to have_content("1")
    expect(page).to have_content("10")
  end
end
