class CalcNutritionController < ApplicationController
  def show
    @nutrients = Nutrient.all
    @foods = Food.all
  end
end
