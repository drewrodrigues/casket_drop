class AddAttributesToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users do |u|
      u.string :address
      u.string :bottom_fit
      u.string :city
      u.float :shoe_size
      u.string :state
      u.string :style
      u.string :top_size
      u.integer :waist_size
    end
  end
end
