class CreateYelpers < ActiveRecord::Migration
  def change
    create_table :yelpers do |t|
      t.string :name
      t.string :location
      t.integer :number_of_reviews
      t.string :image_url
      t.string :uid

      t.timestamps null: false
    end
  end
end
