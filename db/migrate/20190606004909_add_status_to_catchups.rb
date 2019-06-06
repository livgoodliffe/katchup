class AddStatusToCatchups < ActiveRecord::Migration[5.2]
  def change
    t.integer :status, null: false, default: 0
  end
end
