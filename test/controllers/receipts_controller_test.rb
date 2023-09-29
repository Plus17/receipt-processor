require "test_helper"

class ReceiptsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payload = {
      retailer: "Target",
      purchaseDate: "2022-01-01",
      purchaseTime: "13:01",
      items: [
        {
          shortDescription: "Mountain Dew 12PK",
          price: "6.49"
        }, {
          shortDescription: "Emils Cheese Pizza",
          price: "12.25"
        }, {
          shortDescription: "Knorr Creamy Chicken",
          price: "1.26"
        }, {
          shortDescription: "Doritos Nacho Cheese",
          price: "3.35"
        }, {
          shortDescription: "   Klarbrunn 12-PK 12 FL OZ  ",
          price: "12.00"
        }
      ],
      total: "35.35"
    }
  end

  test "should process receipt" do
    assert_difference("Receipt.count") do
      create_receipt(@payload)
    end

    assert_response :success
    assert JSON.parse(response.body)["id"].present?
  end

  test "should show receipt points" do
    create_receipt(@payload)
    assert_response :success

    get receipt_points_url(JSON.parse(response.body)["id"]), headers: {"Accept" => "application/json"}
    assert_response :success
    assert JSON.parse(response.body) == {"points" => 28}
  end

  def create_receipt(payload)
    post receipts_url, params: payload, headers: {"Accept" => "application/json"}
  end
end
