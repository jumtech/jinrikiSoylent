class CreateNecessaryNutrientQuantities < ActiveRecord::Migration
  def change
    create_table :necessary_nutrient_quantities do |t|
      t.string :name
      t.float :quantity
      t.string :unit

      t.timestamps null: false
    end
  end
end
