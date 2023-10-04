class ReceiptPointCalculator
  def initialize(receipt_data)
    @receipt = receipt_data
    @points = 0
    @bonus_time_start = Time.parse("14:00")
    @bonus_time_end = Time.parse("16:00")
  end

  def calculate_points
    [
      retailer_points,
      total_points,
      items_points,
      purchase_date_points,
      purchase_time_points
    ].sum
  end

  def retailer_points
    receipt["retailer"].scan(/[a-zA-Z0-9]/).count
  end

  def total_points
    total = receipt["total"].to_f
    points = 0
    points += 50 if total == total.to_i
    points += 25 if (total * 100 % 25).zero?
    points
  end

  def items_points
    item_pairs_points = (receipt["items"].size / 2) * 5 # Ruby rounds down for integers by default so no need to ceil
    description_points = receipt["items"].sum do |item|
      description = item["shortDescription"].strip
      (description.length % 3).zero? ? (item["price"].to_f * 0.2).ceil : 0
    end
    item_pairs_points + description_points
  end

  def purchase_date_points
    purchase_date = Date.parse(receipt["purchaseDate"])
    purchase_date.day.odd? ? 6 : 0
  end

  def purchase_time_points
    Time.parse(receipt["purchaseTime"]).between?(bonus_time_start, bonus_time_end) ? 10 : 0
  end

  private

  attr_reader :receipt, :bonus_time_start, :bonus_time_end
end
