require "csv"

CSV.foreach('db/initFoods.csv') do |food|
  Food.create(:name => food[0], :unit => food[1], :calories => food[2], :totalFat => food[3], :totalCarbohydrate => food[4], :protein => food[5])
end

CSV.foreach('db/initNutrients.csv') do |nutrient|
  Nutrient.create(:name =>  nutrient[0], :quantity =>  nutrient[1], :unit =>  nutrient[2])
end
