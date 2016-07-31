class Food < ActiveRecord::Base
  def getNutrition(i)
    case i
    when 0 then
      return calories
    when 1 then
      return protein
    when 2 then
      return totalFat
    when 3 then
      return saturatedFat
    when 4 then
      return polyunsaturatedFat
    when 5 then
      return monounsaturatedFat
    when 6 then
      return cholesterol
    when 7 then
      return totalCarbohydrate
    when 8 then
      return dietaryFiber
    when 9 then
      return solubleFiber
    when 10 then
      return sodium
    when 11 then
      return potassium
    when 12 then
      return calcium
    when 13 then
      return magnesium
    when 14 then
      return iron
    when 15 then
      return zinc
    when 16 then
      return copper
    when 17 then
      return manganese
    when 18 then
      return iodine
    when 19 then
      return selenium
    when 20 then
      return chromium
    when 21 then
      return molybdenum
    when 22 then
      return vitaminA
    when 23 then
      return vitaminD
    when 24 then
      return vitaminE
    when 25 then
      return vitaminK
    when 26 then
      return thiamin
    when 27 then
      return riboflavin
    when 28 then
      return niacin
    when 29 then
      return vitaminB6
    when 30 then
      return vitaminB12
    when 31 then
      return folate
    when 32 then
      return vitaminB5
    when 33 then
      return biotin
    when 34 then
      return vitaminC
    else
      return nil
    end
  end
end
