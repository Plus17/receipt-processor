FactoryBot.define do
  factory :receipt do
    data {
      {
        "retailer" => "Target",
        "purchaseDate" => "2022-01-01",
        "purchaseTime" => "13:01",
        "items" => [
          {"shortDescription" => "Mountain Dew 12PK", "price" => "6.49"},
          {"shortDescription" => "Emils Cheese Pizza", "price" => "12.25"}
        ],
        "total" => "35.35"
      }
    }
    points { 1 }
  end
end
