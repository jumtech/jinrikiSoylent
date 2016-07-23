class RenameNutrient < ActiveRecord::Migration
  def change
    rename_table :necessary_nutrient_quantities, :nutrients
  end
end
