class CreateDownvotes < ActiveRecord::Migration
  def change
    create_table :downvotes do |t|
      t.belongs_to :user
      t.belongs_to :review
    end
    add_index :downvotes, [:user_id, :review_id], unique: true
  end
end
