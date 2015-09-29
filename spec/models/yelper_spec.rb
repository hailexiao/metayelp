require 'rails_helper'

RSpec.describe Yelper, type: :model do

  before (:each) do
    @review = FactoryGirl.create(:review)
    5.times do
      FactoryGirl.create(:downvote, review: @review)
    end
    7.times do
      FactoryGirl.create(:upvote, review: @review)
    end
    @yelper = @review.yelper
  end

  it "should destroy associated reviews" do
    reviews = @yelper.reviews
    @yelper.destroy
    expect(reviews).to be_empty
  end

  it "should destroy associated upvotes and downvotes" do
    upvotes = @review.upvotes
    downvotes = @review.downvotes
    @yelper.destroy
    expect(upvotes).to be_empty
    expect(downvotes).to be_empty
  end

  it { should have_many :reviews }
  it { should have_many(:reviews).dependent(:destroy) }

  it { should validate_presence_of :name }

  it { should validate_presence_of :number_of_reviews }
  it { should validate_numericality_of :number_of_reviews }

  it { should validate_presence_of :image_url }

  it { should validate_presence_of :uid }
end
