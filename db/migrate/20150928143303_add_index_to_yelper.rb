class AddIndexToYelper < ActiveRecord::Migration
  def change
    add_index :yelpers, :uid, unique: true
  end
end
