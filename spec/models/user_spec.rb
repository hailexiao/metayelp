require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :reviews }

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
