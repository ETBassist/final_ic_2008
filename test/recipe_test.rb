require 'minitest/autorun'
require 'minitest/pride'

require './lib/ingredient'
require './lib/pantry'
require './lib/recipe'

class RecipeTest < MiniTest::Test
  def setup
    @ingredient1 = Ingredient.new({name: "Cheese", unit: "oz", calories: 50})
    @ingredient2 = Ingredient.new({name: "Macaroni", unit: "oz", calories: 200})
    @recipe1 = Recipe.new("Mac and Cheese")
  end

  def test_it_exists
    assert_instance_of Recipe, @recipe1
  end

  def test_it_can_name_and_ingredients_required_attributes
    assert_equal "Mac and Cheese", @recipe1.name
    assert_equal ({}), @recipe1.ingredients_required
  end
end
