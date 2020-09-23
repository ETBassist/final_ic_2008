require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'

require './lib/ingredient'
require './lib/pantry'
require './lib/recipe'
require './lib/cook_book.rb'

class CookBookTest < MiniTest::Test
  def setup
    Date.stubs(:today).returns(Date.new(2020, 4, 22))
    @ingredient1 = Ingredient.new({name: "Cheese", unit: "oz", calories: 100})
    @ingredient2 = Ingredient.new({name: "Macaroni", unit: "oz", calories: 30})
    @recipe1 = Recipe.new("Mac and Cheese")
    @recipe1.add_ingredient(@ingredient1, 2)
    @recipe1.add_ingredient(@ingredient2, 8)
    @recipe2 = Recipe.new("Cheese Burger")
    @ingredient3 = Ingredient.new({name: "Ground Beef", unit: "oz", calories: 100})
    @ingredient4 = Ingredient.new({name: "Bun", unit: "g", calories: 75})
    @recipe2.add_ingredient(@ingredient1, 2)
    @recipe2.add_ingredient(@ingredient3, 4)
    @recipe2.add_ingredient(@ingredient4, 1)
    @cookbook = CookBook.new
    @pantry = Pantry.new
  end

  def test_it_exists
    assert_instance_of CookBook, @cookbook
  end

  def test_has_recipes
    assert_equal [], @cookbook.recipes
    @cookbook.add_recipe(@recipe1)
    @cookbook.add_recipe(@recipe2)
    assert_equal [@recipe1, @recipe2], @cookbook.recipes
  end

  def test_it_can_get_all_ingredients_for_recipes
    @cookbook.add_recipe(@recipe1)
    @cookbook.add_recipe(@recipe2)
    assert_equal ["Cheese", "Macaroni", "Ground Beef", "Bun"], @cookbook.ingredients
  end

  def test_it_can_find_highest_calorie_meal
    @cookbook.add_recipe(@recipe1)
    @cookbook.add_recipe(@recipe2)
    assert_equal @recipe2, @cookbook.highest_calorie_meal
  end

  def test_can_give_date_created
    assert_equal "04-22-2020", @cookbook.date
  end

  def test_it_can_give_summary_of_recipes
    expected = [{
      :name => "Cheese Burger", 
      :details => {
        :ingredients => [{
          :ingredient => "Ground Beef",
          :amount => "4 oz"
        }, 
          {
          :ingredient => "Cheese",
          :amount => "2 oz"
        },
          {
           :ingredient => "Bun",
           :amount => "1 g"
        }],
        :total_calories => 675
      }},
      {
        :name => "Macaroni and Cheese",
        :details =>  {
          :ingredients => [{
            :ingredient => "Macaroni",
            :amount => "8 oz"
          }, 
        {
          :ingredient => "Cheese",
          :amount => "2 oz"
          }],
        :total_calories => 440
      }},
    ]
    assert_equal expected, @cookbook.summary
  end
end
