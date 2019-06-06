class RenameCatchupUsersToGuests < ActiveRecord::Migration[5.2]

  def change
    rename_table :catch_up_users, :guests
  end

end
