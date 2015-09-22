class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :body, null: false
      t.integer :rating, null: false
      t.belongs_to :user, null: false
      t.belongs_to :yelper, null: false

      t.timestamps null: false
    end
  end
end
