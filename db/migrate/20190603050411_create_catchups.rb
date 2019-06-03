class CreateCatchups < ActiveRecord::Migration[5.2]
  def change
    create_table :catchups do |t|
      t.references :user, foreign_key: true
      t.references :spot, foreign_key: true
      t.datetime :time

      t.timestamps
    end
  end
end
