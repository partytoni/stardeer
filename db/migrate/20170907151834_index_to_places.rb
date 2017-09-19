class IndexToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_index :places, [:site, :place_id], unique: true
  end
end
