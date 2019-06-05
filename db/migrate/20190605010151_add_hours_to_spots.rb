class AddHoursToSpots < ActiveRecord::Migration[5.2]
  def change
    add_column :spots, :hours, :string
  end
end
