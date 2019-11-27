class AddZomatoToSpots < ActiveRecord::Migration[5.2]
  def change
    add_column :spots, :res_id, :string
    add_column :spots, :thumbnail, :string
    add_column :spots, :suburb, :string
    add_column :spots, :city, :string
  end
end
