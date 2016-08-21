require "csv"

attributes = Food.getAttributes()

CSV.foreach('db/initFoods.csv') do |food|
  hash = {}
  # 属性名とinDataの組をハッシュに格納
  for i in 0..attributes.length-1 do
    hash.store(attributes[i], food[i])
  end

  Food.create(hash)
end

CSV.foreach('db/initNutrients.csv') do |nutrient|
  Nutrient.create(
  :name =>  nutrient[0],
  :quantity =>  nutrient[1],
  :unit =>  nutrient[2])
end
