class AddCoordinatesToSpots < ActiveRecord::Migration[5.2]
  def change
    add_column :spots, :latitude, :float
    add_column :spots, :longitude, :float
  end
end
