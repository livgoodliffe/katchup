class AddStatusToCatchups < ActiveRecord::Migration[5.2]
  def change
    add_column :catchups, :status, :integer, null: false, default: 0
  end
end
