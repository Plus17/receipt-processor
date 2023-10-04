class Receipt < ApplicationRecord
  validate :retailer_presence
  validate :purchase_date_presence
  validate :purchase_time_presence
  validate :items_presence
  validate :total_presence

  validate :valid_purchase_date_format
  validate :valid_purchase_time_format
  validate :valid_items_format
  validate :valid_total_format

  private

  def retailer_presence
    errors.add(:data, "retailer can't be blank") unless data["retailer"].present?
  end

  def purchase_date_presence
    errors.add(:data, "purchaseDate can't be blank") unless data["purchaseDate"].present?
  end

  def purchase_time_presence
    errors.add(:data, "purchaseTime can't be blank") unless data["purchaseTime"].present?
  end

  def items_presence
    errors.add(:data, "items can't be blank") unless data["items"].is_a?(Array) && data["items"].any?
  end

  def total_presence
    errors.add(:data, "total can't be blank") unless data["total"].present?
  end

  def valid_purchase_date_format
    Date.strptime(data["purchaseDate"], "%Y-%m-%d")
  rescue ArgumentError
    errors.add(:data, "purchaseDate is not in a valid format")
  end

  def valid_purchase_time_format
    Time.strptime(data["purchaseTime"], "%H:%M")
  rescue ArgumentError
    errors.add(:data, "purchaseTime is not in a valid format")
  end

  def valid_items_format
    data["items"].each do |item|
      unless item["shortDescription"].present? && valid_price_format?(item["price"])
        errors.add(:data, "items format is invalid")
        break
      end
    end
  end

  def valid_total_format
    errors.add(:data, "total format is invalid") unless valid_price_format?(data["total"])
  end

  def valid_price_format?(price)
    !!Float(price)
  rescue
    false
  end
end
