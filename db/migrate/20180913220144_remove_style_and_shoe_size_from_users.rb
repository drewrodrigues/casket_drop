class RemoveStyleAndShoeSizeFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :style, :string
    remove_column :users, :shoe_size, :float
  end
end
