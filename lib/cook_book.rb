require 'date'

class CookBook
  attr_reader :recipes

  def initialize
    @recipes = []
    @date = Date.today
  end

  def add_recipe(recipe)
    @recipes << recipe
  end

  def ingredients
    @recipes.flat_map do |recipe|
      recipe.ingredients.map(&:name)
    end.uniq
  end

  def highest_calorie_meal
    @recipes.max_by do |recipe|
      recipe.total_calories
    end
  end

  def date
    @date.strftime("%m-%d-%Y")
  end

  def summary
    @recipes.map do |recipe|
      recipe.ingredients_required
    end
  end
end
