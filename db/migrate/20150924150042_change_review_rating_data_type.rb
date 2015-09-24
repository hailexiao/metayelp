class ChangeReviewRatingDataType < ActiveRecord::Migration
  def up
    change_table :reviews do |t|
      t.change :rating, :string
    end
  end

  def down
    change_table :reviews do |t|
      t.change :rating, 'integer USING CAST(rating AS integer)'
    end
  end
end
