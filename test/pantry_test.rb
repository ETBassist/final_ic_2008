require 'minitest/autorun'
require 'minitest/pride'

require './lib/pantry'

class PantryTest < MiniTest::Test
  def setup
    @ingredient1 = Ingredient.new({name: "Cheese", unit: "oz", calories: 50})
  end

  def test_it_exists
    assert_instance_of Ingredient, @ingredient1
  end
end
