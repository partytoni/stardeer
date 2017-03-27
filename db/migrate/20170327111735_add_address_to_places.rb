class AddAddressToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :site, :string
    add_column :places, :place_id, :string
    add_column :places, :city, :string
    add_column :places, :cc, :string
  end
end
