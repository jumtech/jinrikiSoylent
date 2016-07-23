class CreateFoodInfos < ActiveRecord::Migration
  def change
    create_table :food_infos do |t|
      t.string :name
      t.string :unit
      t.float :calories
      t.float :totalFat
      t.float :totalCarbohydrate
      t.float :protein

      t.timestamps null: false
    end
  end
end
