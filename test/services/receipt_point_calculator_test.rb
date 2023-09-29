require "test_helper"

class ReceiptPointCalculatorTest < ActiveSupport::TestCase
  test "calculates points for a receipt" do
    receipt_json = '{
      "retailer": "Target",
      "purchaseDate": "2022-01-01",
      "purchaseTime": "13:01",
      "items": [
        {
          "shortDescription": "Mountain Dew 12PK",
          "price": "6.49"
        },{
          "shortDescription": "Emils Cheese Pizza",
          "price": "12.25"
        },{
          "shortDescription": "Knorr Creamy Chicken",
          "price": "1.26"
        },{
          "shortDescription": "Doritos Nacho Cheese",
          "price": "3.35"
        },{
          "shortDescription": "   Klarbrunn 12-PK 12 FL OZ  ",
          "price": "12.00"
        }
      ],
      "total": "35.35"
    }'

    points_calculator = ReceiptPointCalculator.new(JSON.parse(receipt_json))

    assert_equal 28, points_calculator.calculate_points
  end

  test "calculates points for a receipt with bonus" do
    receipt_json = '{
      "retailer": "M&M Corner Market",
      "purchaseDate": "2022-03-20",
      "purchaseTime": "14:33",
      "items": [
        {
          "shortDescription": "Gatorade",
          "price": "2.25"
        },{
          "shortDescription": "Gatorade",
          "price": "2.25"
        },{
          "shortDescription": "Gatorade",
          "price": "2.25"
        },{
          "shortDescription": "Gatorade",
          "price": "2.25"
        }
      ],
      "total": "9.00"
    }'

    points_calculator = ReceiptPointCalculator.new(JSON.parse(receipt_json))

    assert_equal 109, points_calculator.calculate_points
  end
end
