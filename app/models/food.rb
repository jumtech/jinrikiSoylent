class Food < ActiveRecord::Base
  def getNutrition(id)
    case id
    when 1 then
      return calories
    when 2 then
      return totalFat
    when 3 then
      return totalCarbohydrate
    when 4 then
      return protein
    else
      return nil
    end
  end
end
