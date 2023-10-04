require "test_helper"

class ReceiptPointCalculatorTest < ActiveSupport::TestCase
  setup do
    @receipt_json = {
      "retailer" => "Target",
      "purchaseDate" => "2022-01-01",
      "purchaseTime" => "13:01",
      "items" => [
        {
          "shortDescription" => "Mountain Dew 12PK",
          "price" => "6.49"
        }, {
          "shortDescription" => "Emils Cheese Pizza",
          "price" => "12.25"
        }, {
          "shortDescription" => "Knorr Creamy Chicken",
          "price" => "1.26"
        }, {
          "shortDescription" => "Doritos Nacho Cheese",
          "price" => "3.35"
        }, {
          "shortDescription" => "   Klarbrunn 12-PK 12 FL OZ  ",
          "price" => "12.00"
        }
      ],
      "total" => "35.35"
    }

    @receipt_json_with_bonus = {
      "retailer" => "M&M Corner Market",
      "purchaseDate" => "2022-03-20",
      "purchaseTime" => "14:33",
      "items" => [
        {
          "shortDescription" => "Gatorade",
          "price" => "2.25"
        }, {
          "shortDescription" => "Gatorade",
          "price" => "2.25"
        }, {
          "shortDescription" => "Gatorade",
          "price" => "2.25"
        }, {
          "shortDescription" => "Gatorade",
          "price" => "2.25"
        }
      ],
      "total" => "9.00"
    }
  end

  test "retailer_points for Target" do
    points_calculator = ReceiptPointCalculator.new(@receipt_json)

    assert_equal 6, points_calculator.retailer_points
  end

  test "items_points for 6 items and descriptions" do
    points_calculator = ReceiptPointCalculator.new(@receipt_json)

    assert_equal 16, points_calculator.items_points
  end

  test "total_points when total is not a round dollar amount and is not a multiple of 0.25" do
    points_calculator = ReceiptPointCalculator.new(@receipt_json)

    assert_equal 0, points_calculator.total_points
  end

  test "purchase_date_points when purchase date is odd" do
    points_calculator = ReceiptPointCalculator.new(@receipt_json)

    assert_equal 6, points_calculator.purchase_date_points
  end

  test "purchase_time_points when time is not between 2:00pm and 4:00pm" do
    points_calculator = ReceiptPointCalculator.new(@receipt_json)

    assert_equal 0, points_calculator.purchase_time_points
  end
  test "sum of points for a receipt" do
    points_calculator = ReceiptPointCalculator.new(@receipt_json)

    assert_equal 28, points_calculator.calculate_points
  end

  test "retailer_points ignores non alphanumeric characters like &" do
    points_calculator = ReceiptPointCalculator.new(@receipt_json_with_bonus)

    assert_equal 14, points_calculator.retailer_points
  end

  test "items_points for 4 items" do
    points_calculator = ReceiptPointCalculator.new(@receipt_json_with_bonus)

    assert_equal 10, points_calculator.items_points
  end

  test "total_points when total is a round dollar amount and is a multiple of 0.25" do
    points_calculator = ReceiptPointCalculator.new(@receipt_json_with_bonus)

    assert_equal 75, points_calculator.total_points
  end

  test "calculates points for odd purchase date for receipt with bonus" do
    points_calculator = ReceiptPointCalculator.new(@receipt_json_with_bonus)

    assert_equal 0, points_calculator.purchase_date_points
  end

  test "purchase_time_points 2:33pm is between 2:00pm and 4:00pm" do
    points_calculator = ReceiptPointCalculator.new(@receipt_json_with_bonus)

    assert_equal 10, points_calculator.purchase_time_points
  end

  test "ccalculate_points for a receipt with bonus" do
    points_calculator = ReceiptPointCalculator.new(@receipt_json_with_bonus)

    assert_equal 109, points_calculator.calculate_points
  end
end
