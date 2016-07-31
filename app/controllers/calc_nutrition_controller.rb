class CalcNutritionController < ApplicationController

  def common()
    @needs = []
    @supplies = []
    @status = []
    @nutrients.each.with_index(0) do |nutrient, i|
      need = nutrient.quantity * @term.to_i * @percent.to_i / 100
      @needs << need.round(1)
       supply = 0
      @currentFoods.each do |food|
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
    @currentFoods = []
    @term = 5
    @percent = 100
    common()
  end

  def update
    # DBからレコードを取得
    @nutrients = Nutrient.all
    @foods = Food.all

    # formからパラメタを取得
    @term = params["form"]["term"]
    if @term == nil
      @term = 5
    end

    @percent = params["form"]["percent"]
    if @percent == nil
      @percent = 100
    end

    addedFoodId = params["form"]["addedFoodId"]
    if addedFoodId == nil
      addedFoodId = ""
    end

    quantities = params["quantities"]

    currentFoodIds = params["form"]["currentFoodIds"]
    if currentFoodIds == nil
      currentFoodIds = []
    end

    # 現在の食材を用意
    @currentFoods = []
    if currentFoodIds.kind_of?(String)
      @currentFoods << @foods.find(currentFoodIds)
    else
      currentFoodIds.each do |id|
        @currentFoods << @foods.find(id)
      end
    end

    # 各食材のquantityをパラメタ値で設定
    if quantities == nil
      @currentFoods.each.with_index(0) do |food, i|
        food.quantity = 1
      end
    else
      @currentFoods.each.with_index(0) do |food, i|
        food.quantity = quantities[i].to_f
      end
    end

    # 食材の追加
    if addedFoodId != ""
      if !(currentFoodIds.include?(addedFoodId))
        addedFood = @foods.find(addedFoodId)
        addedFood.quantity = 1
        @currentFoods << addedFood
      end
    end

    # DEBUG
    @consoles = [
      "@term=#{@term}",
      "@percent=#{@percent}",
      "quantities=#{quantities}",
      "currentFoodIds=#{currentFoodIds}",
      "@currentFoods=#{@currentFoods}"
    ]
    common()
  end
end
