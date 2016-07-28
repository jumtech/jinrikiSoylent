class CalcNutritionController < ApplicationController

  def common()
    @nutrients = Nutrient.all
    @foods = Food.all
    @needArr = []
    @sumArr = []
    @nutrients.each.with_index(0) do |nutrient, i|
      need = nutrient.quantity * @term.to_i * @percent.to_i / 100
      @needArr << need.round(1)
      sum = 0
      @foods.each do |food|
        sum += food.getNutrition(i)
      end
      @sumArr << sum.round(1)
    end
  end

  def show
    @term = 1
    @percent = 80
    common()
  end

  def updateTarget
    @term = params[:term]
    @percent = params[:percent]
    @console = "term=#{@term}, percent=#{@percent}"
    common()
  end
end
