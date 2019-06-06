class AddStatusToGuests < ActiveRecord::Migration[5.2]
  def change
    add_column :guests, :status, :integer, null: false, default: 0
  end
end
