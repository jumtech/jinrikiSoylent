class AddColumnFoods < ActiveRecord::Migration
  def change
      add_column :foods, :saturatedFat, :float
      add_column :foods, :polyunsaturatedFat, :float
      add_column :foods, :monounsaturatedFat, :float
      add_column :foods, :cholesterol, :float
      add_column :foods, :dietaryFiber, :float
      add_column :foods, :solubleFiber, :float
      add_column :foods, :sodium, :float
      add_column :foods, :potassium, :float
      add_column :foods, :calcium, :float
      add_column :foods, :magnesium, :float
      add_column :foods, :iron, :float
      add_column :foods, :zinc, :float
      add_column :foods, :copper, :float
      add_column :foods, :manganese, :float
      add_column :foods, :iodine, :float
      add_column :foods, :selenium, :float
      add_column :foods, :chromium, :float
      add_column :foods, :molybdenum, :float
      add_column :foods, :vitaminA, :float
      add_column :foods, :vitaminD, :float
      add_column :foods, :vitaminE, :float
      add_column :foods, :vitaminK, :float
      add_column :foods, :thiamin, :float
      add_column :foods, :riboflavin, :float
      add_column :foods, :niacin, :float
      add_column :foods, :vitaminB6, :float
      add_column :foods, :vitaminB12, :float
      add_column :foods, :folate, :float
      add_column :foods, :vitaminB5, :float
      add_column :foods, :biotin, :float
      add_column :foods, :vitaminC, :float
    end
end
