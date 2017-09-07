class IndexToPosts < ActiveRecord::Migration[5.0]
  def change
    add_index :posts, [:user_id, :place_id], unique: true
  end
end
