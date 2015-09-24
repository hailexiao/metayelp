require 'rails_helper'

feature 'user can vote on reviews', %{
  As a reviewer of Yelpers
  I want to vote on reviews of yelpers
  So I can let people know which yelper reviewers are the best at leaving yelp reviews.
} do

  # Acceptance criteria
  # [] When an unauthenticated user tries to vote, they cannot.
  # [] When an authenticated user upvotes, the review's upvotes goes up by one.
  # [] When an authenticated user downvotes, the review's downvotes goes up by one.
  # [] Users can only vote once per review.

  scenario 'an unauthenticated user tries to vote' do
    review = FactoryGirl.create(:review)
    yelper = review.yelpers

    visit yelper_path(yelper)

    click_link('upvote')

    expect(page).to have_content 'You need to sign in or sign up'
  end

end
