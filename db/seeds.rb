require "csv"

CSV.foreach('db/initFoods.csv') do |food|
  Food.create(
  :name => food[0],
  :unit => food[1],
  :calories => food[2],
  :protein => food[3],
  :totalFat => food[4],
  :saturatedFat => food[5],
  :monounsaturatedFat => food[6],
  :polyunsaturatedFat => food[7],
  :cholesterol => food[8],
  :totalCarbohydrate => food[9],
  :dietaryFiber => food[10],
  :solubleFiber => food[11],
  :sodium => food[12],
  :potassium => food[13],
  :calcium => food[14],
  :magnesium => food[15],
  :iron => food[16],
  :zinc => food[17],
  :copper => food[18],
  :manganese => food[19],
  :iodine => food[20],
  :selenium => food[21],
  :chromium => food[22],
  :molybdenum => food[23],
  :vitaminA => food[24],
  :vitaminD => food[25],
  :vitaminE => food[26],
  :vitaminK => food[27],
  :thiamin => food[28],
  :riboflavin => food[29],
  :niacin => food[30],
  :vitaminB6 => food[31],
  :vitaminB12 => food[32],
  :folate => food[33],
  :vitaminB5 => food[34],
  :biotin => food[35],
  :vitaminC => food[36]
  )
end

CSV.foreach('db/initNutrients.csv') do |nutrient|
  Nutrient.create(
  :name =>  nutrient[0],
  :quantity =>  nutrient[1],
  :unit =>  nutrient[2])
end
