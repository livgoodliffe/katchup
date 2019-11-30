class RemoveForeignKeys < ActiveRecord::Migration[5.2]
  def change

    remove_foreign_key :menu_items, :spots

  end
end
