class AddReviewCountToYelpers < ActiveRecord::Migration
  def change
    add_column :yelpers, :reviews_count, :integer, default: 0
  end
end
