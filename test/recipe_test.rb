require 'minitest/autorun'
require 'minitest/pride'

require './lib/ingredient'
require './lib/pantry'
require './lib/recipe'

class RecipeTest < MiniTest::Test
  def setup
    @ingredient1 = Ingredient.new({name: "Cheese", unit: "oz", calories: 100})
    @ingredient2 = Ingredient.new({name: "Macaroni", unit: "oz", calories: 30})
    @recipe1 = Recipe.new("Mac and Cheese")
  end

  def test_it_exists
    assert_instance_of Recipe, @recipe1
  end

  def test_it_can_name_and_ingredients_required_attributes
    assert_equal "Mac and Cheese", @recipe1.name
    assert_equal ({}), @recipe1.ingredients_required
  end

  def test_it_can_add_required_ingredients
    @recipe1.add_ingredient(@ingredient1, 2)
    @recipe1.add_ingredient(@ingredient1, 4)
    @recipe1.add_ingredient(@ingredient2, 8)
    expected = {
      @ingredient1 => 6,
      @ingredient2 => 8
    }
    assert_equal expected, @recipe1.ingredients_required
  end

  def test_it_can_get_ingredients_without_amounts
    @recipe1.add_ingredient(@ingredient1, 2)
    @recipe1.add_ingredient(@ingredient1, 4)
    @recipe1.add_ingredient(@ingredient2, 8)
    assert_equal [@ingredient1, @ingredient2], @recipe1.ingredients
  end

  def test_it_can_get_total_calories
    @recipe1.add_ingredient(@ingredient1, 2)
    @recipe1.add_ingredient(@ingredient2, 8)
    assert_equal 440, @recipe1.total_calories
  end
end
