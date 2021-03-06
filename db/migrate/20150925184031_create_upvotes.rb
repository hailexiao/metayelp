class CreateUpvotes < ActiveRecord::Migration
  def change
    create_table :upvotes do |t|
      t.belongs_to :user
      t.belongs_to :review
    end
    add_index :upvotes, [:user_id, :review_id], unique: true
  end
end
