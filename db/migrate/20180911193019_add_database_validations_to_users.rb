class AddDatabaseValidationsToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:users, :admin, false, false)
    change_column_null(:users, :email, false)
    change_column_null(:users, :password, false)
  end
end
