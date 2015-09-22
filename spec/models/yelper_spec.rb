require 'rails_helper'

RSpec.describe Yelper, type: :model do
  it { should have_many :reviews }

  it { should validate_presence_of :name }

  it { should validate_presence_of :number_of_reviews }
  it { should validate_numericality_of :number_of_reviews }

  it { should validate_presence_of :image_url }

  it { should validate_presence_of :uid }
end
