class AddArraysToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :favorite_tops, :string, array: true, default: []
    add_column :users, :favorite_bottoms, :string, array: true, default: []
    add_column :users, :favorite_colors, :string, array: true, default: []
  end
end
