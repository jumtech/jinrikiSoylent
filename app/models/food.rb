class Food < ActiveRecord::Base
  def getNutrition(i)
    case i
    when 0 then
      return calories
    when 1 then
      return totalFat
    when 2 then
      return totalCarbohydrate
    when 3 then
      return protein
    else
      return nil
    end
  end
end
