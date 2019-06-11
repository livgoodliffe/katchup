class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true
      t.boolean :dismissed, null: false, default: false
      t.integer :variety, null: false
      t.text :content

      t.timestamps
    end
  end
end
