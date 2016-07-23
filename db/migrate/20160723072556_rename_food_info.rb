class RenameFoodInfo < ActiveRecord::Migration
  def change
    rename_table :food_infos, :foods
  end
end
