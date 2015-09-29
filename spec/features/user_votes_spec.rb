require 'rails_helper'

feature 'user can vote on reviews', %{
  As a reviewer of Yelpers
  I want to vote on reviews of yelpers
  So I can let people know which yelper reviewers are
  the best at yelp reviewing.
} do
  # Acceptance criteria
  # [*] When an unauthenticated user tries to vote, they cannot.
  # [*] When an authenticated user upvotes, the review's upvotes goes up 1.
  # [*] When an authenticated user downvotes, the review's downvotes goes down 1
  # [*] Users can only vote once per review.
  scenario 'an unauthenticated user tries to vote', js: true do
    review = FactoryGirl.create(:review)
    yelper = review.yelper
    binding.pry
    10.times do
      FactoryGirl.create(:upvote, review: review)
    end

    visit yelper_path(yelper)

    expect(page).to have_content '10'

    within(".votes") do
      find('#up-vote').trigger('click')
    end

    expect(page).to have_content '10'
  end

  scenario "signed in user upvotes,review's upvotes goes up 1", js: true do
    review = FactoryGirl.create(:review)
    yelper = review.yelper
    user = review.user

    10.times do
      FactoryGirl.create(:upvote, review: review)
    end

    sign_in_as(user)

    visit yelper_path(yelper)

    within(".votes") do
      find('#up-vote').trigger('click')
    end

    expect(page).to have_content("11")
  end

  scenario "signed in user downvotes, review's downvotes go down 1", js: true do
    review = FactoryGirl.create(:review)
    yelper = review.yelper
    user = review.user

    10.times do
      FactoryGirl.create(:upvote, review: review)
    end

    sign_in_as(user)
    visit yelper_path(yelper)

    within(".votes") do
      find('#down-vote').trigger('click')
    end

    expect(page).to have_content("1")
  end

  scenario "signed in user tries to vote twice on the same review", js: true do
    review = FactoryGirl.create(:review)
    yelper = review.yelper
    user = review.user

    10.times do
      FactoryGirl.create(:upvote, review: review)
    end

    sign_in_as(user)
    visit yelper_path(yelper)

    within(".votes") do
      find('#up-vote').trigger('click')
    end

    expect(page).to have_content("1")

    within(".votes") do
      find('#up-vote').trigger('click')
    end

    expect(page).to have_content("1")
  end

  scenario "an authenticated upvotes then downvotes", js: true do
    review = FactoryGirl.create(:review)
    yelper = review.yelper
    user = review.user

    10.times do
      FactoryGirl.create(:upvote, review: review)
    end

    sign_in_as(user)
    visit yelper_path(yelper)

    within(".votes") do
      find('#up-vote').trigger('click')
    end

    expect(page).to have_content("11")

    within(".votes") do
      find('#down-vote').trigger('click')
    end

    expect(page).to have_content("1")
    expect(page).to have_content("10")
  end
end
