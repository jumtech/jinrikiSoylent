class CalcNutritionController < ApplicationController

  def common()
    @needs = []
    @supplies = []
    @status = []
    @nutrients.each.with_index(0) do |nutrient, i|
      need = nutrient.quantity * @term.to_i * @percent.to_i / 100
      @needs << need.round(1)
       supply = 0
      @foods.each do |food|
        supply += food.getNutrition(i) * food.quantity
      end
      @supplies <<  supply.round(1)
      if need >  supply
        @status << "shortage"
      else
        @status << "enough"
      end
    end
  end

  def show
    @nutrients = Nutrient.all
    @foods = Food.all
    @foods.each do |food|
      food.quantity = 1
    end
    @term = 1
    @percent = 80
    common()
  end

  def update
    @nutrients = Nutrient.all
    @foods = Food.all
    @term = params[:term]
    @percent = params[:percent]
    quantities = params[:quantities]
    @foods.each.with_index(0) do |food, i|
      if quantities == nil
        food.quantity = 1
      else
        food.quantity = quantities[i].to_f
      end
    end
    @console = "term=#{@term}, percent=#{@percent}, quantities=#{quantities}"
    common()
  end
end
