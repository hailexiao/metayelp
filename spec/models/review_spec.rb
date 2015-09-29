require 'rails_helper'

RSpec.describe Review, type: :model do

  before (:each) do
    @review = FactoryGirl.create(:review)
    5.times do
      FactoryGirl.create(:downvote, review: @review)
    end
    7.times do
      FactoryGirl.create(:upvote, review: @review)
    end
  end

  it "should destroy associated upvotes and downvotes" do
    upvotes = @review.upvotes
    downvotes = @review.downvotes
    @review.destroy
    expect(upvotes).to be_empty
    expect(downvotes).to be_empty
  end

  it { should have_many(:upvotes).dependent(:destroy) }
  it { should have_many(:downvotes).dependent(:destroy) }

  it { should validate_presence_of :rating }
  it { should validate_numericality_of :rating }
  it { should validate_inclusion_of(:rating).in_range(1..5) }

  it { should validate_presence_of :body }
  it { should validate_length_of(:body).is_at_least(25).is_at_most(5000) }
  it { should validate_presence_of :user }
  it { should validate_presence_of :yelper }

  it { should belong_to :user }
  it { should belong_to :yelper }
end
