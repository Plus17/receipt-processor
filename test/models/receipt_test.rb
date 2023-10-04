require "test_helper"

class ReceiptTest < ActiveSupport::TestCase
  def setup
    @valid_data = {
      "retailer" => "Target",
      "purchaseDate" => "2022-01-01",
      "purchaseTime" => "13:01",
      "items" => [
        {"shortDescription" => "Mountain Dew 12PK", "price" => "6.49"},
        {"shortDescription" => "Emils Cheese Pizza", "price" => "12.25"}
      ],
      "total" => "35.35"
    }
  end

  test "should be valid with valid data" do
    receipt = Receipt.new(data: @valid_data)
    assert receipt.valid?
  end

  test "should be invalid without retailer" do
    receipt = Receipt.new(data: @valid_data.merge("retailer" => ""))
    assert_not receipt.valid?
    assert_includes receipt.errors[:data], "retailer can't be blank"
  end

  test "should be invalid with incorrect purchase date format" do
    receipt = Receipt.new(data: @valid_data.merge("purchaseDate" => "2022 01 01"))
    assert_not receipt.valid?
    assert_includes receipt.errors[:data], "purchaseDate is not in a valid format"
  end

  test "should be invalid with incorrect purchase time format" do
    receipt = Receipt.new(data: @valid_data.merge("purchaseTime" => "1 PM"))
    assert_not receipt.valid?
    assert_includes receipt.errors[:data], "purchaseTime is not in a valid format"
  end

  test "should be invalid without items" do
    receipt = Receipt.new(data: @valid_data.merge("items" => []))
    assert_not receipt.valid?
    assert_includes receipt.errors[:data], "items can't be blank"
  end

  test "should be invalid without items description" do
    receipt = Receipt.new(data: @valid_data.merge("items" => [{"shortDescription" => "", "price" => "12.25"}]))
    assert_not receipt.valid?
    assert_includes receipt.errors[:data], "items format is invalid"
  end

  test "should be invalid with invalid price format" do
    receipt = Receipt.new(data: @valid_data.merge("items" => [{"shortDescription" => "Mountain Dew 12PK", "price" => ""}]))
    assert_not receipt.valid?
    assert_includes receipt.errors[:data], "items format is invalid"
  end

  test "should be invalid with incorrect total format" do
    receipt = Receipt.new(data: @valid_data.merge("total" => "35,35"))
    assert_not receipt.valid?
    assert_includes receipt.errors[:data], "total format is invalid"
  end
end
