class AddPlaceIdToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :place_id, :integer
  end
end
