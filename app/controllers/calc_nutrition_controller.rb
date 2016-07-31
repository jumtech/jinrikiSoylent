class CalcNutritionController < ApplicationController
  MAX_TERM = 14
  DEFAULT_TERM = 5
  MAX_PERCENT = 100
  DEFAULT_PERCENT = 100
  DEFAULT_QUANTITY = 1

  def show
    @nutrients = Nutrient.all
    @foods = Food.all
    @currentFoods = []
    @term = DEFAULT_TERM
    @percent = DEFAULT_PERCENT
    common()
  end

  def update
    # DBからレコードを取得
    @nutrients = Nutrient.all
    @foods = Food.all

    # formからパラメタを取得
    @term = params["form"]["term"]
    if @term == nil
      @term = DEFAULT_TERM
    end

    @percent = params["form"]["percent"]
    if @percent == nil
      @percent = DEFAULT_PERCENT
    end

    addedFoodId = params["form"]["addedFoodId"]
    if addedFoodId == nil
      addedFoodId = ""
    end

    quantities = params["quantities"]

    deletedFoodId = params[:commit_value].gsub(/delete/, "")

    currentFoodIds = params["form"]["currentFoodIds"]
    if currentFoodIds == nil
      currentFoodIds = []
    elsif currentFoodIds.kind_of?(String)
      currentFoodIds = [currentFoodIds]
    end

    # 食材を削除
    currentFoodIds.delete(deletedFoodId)

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
        food.quantity = DEFAULT_QUANTITY
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
        addedFood.quantity = DEFAULT_QUANTITY
        @currentFoods << addedFood
      end
    end

    # DEBUG
    commit_value =
    @consoles = [
      "@term=#{@term}",
      "@percent=#{@percent}",
      "quantities=#{quantities}",
      "currentFoodIds=#{currentFoodIds}",
      "@currentFoods=#{@currentFoods}",
      "params[:commit_value]=#{params[:commit_value]}",
      "deletedFoodId=#{deletedFoodId}"
    ]
    common()
  end

  def common()
    # 期間選択プルダウンの選択肢
    @terms = {}
    for t in 1..MAX_TERM do
      @terms.store(t, t)
    end

    # ％選択プルダウンの選択肢
    @percents = {}
    10.step(MAX_PERCENT, 10) do |p|
      @percents.store(p, p)
    end

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

end
