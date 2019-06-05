class AddAddressToSpots < ActiveRecord::Migration[5.2]
  def change
    add_column :spots, :address, :string
  end
end
