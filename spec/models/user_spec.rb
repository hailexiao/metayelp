require 'rails_helper'

RSpec.describe User, type: :model do

  before (:each) do
    @review = FactoryGirl.create(:review)
    5.times do
      FactoryGirl.create(:downvote, review: @review)
    end
    7.times do
      FactoryGirl.create(:upvote, review: @review)
    end
    @user = @review.user
  end

  it "should destroy associated reviews" do
    reviews = @user.reviews
    @user.destroy
    expect(reviews).to be_empty
  end

  it "should destroy associated upvotes and downvotes" do
    upvotes = @user.upvotes
    downvotes = @user.downvotes
    @user.destroy
    expect(upvotes).to be_empty
    expect(downvotes).to be_empty
  end

  it { should have_many :reviews }
  it { should have_many(:reviews).dependent(:destroy) }

  describe "#admin?" do
    it "is not an admin if the role is not admin" do
      user = FactoryGirl.create(:user, role: "member")
      expect(user.admin?).to eq(false)
    end

    it "is an admin if the role is admin" do
      user = FactoryGirl.create(:user, role: "admin")
      expect(user.admin?).to eq(true)
    end
  end
end
