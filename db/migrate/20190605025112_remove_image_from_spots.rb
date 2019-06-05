class RemoveImageFromSpots < ActiveRecord::Migration[5.2]
  def change
    remove_column :spots, :image, :string
  end
end
