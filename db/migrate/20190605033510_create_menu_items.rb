class CreateMenuItems < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_items do |t|
      t.string :name
      t.string :description
      t.monetize :price, currency: { present: false }
      t.references :spot, foreign_key: true

      t.timestamps
    end
  end
end
