class AddCurrentPeriodEndToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :current_period_end, :Date
  end
end
