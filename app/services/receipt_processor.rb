class ReceiptProcessor
  def create_receipt(receipt)
    receipt.points = ReceiptPointCalculator.new(receipt.data).calculate_points
    receipt.save

    if receipt.invalid?
      return Result.new(created: false, receipt: receipt)
    end

    Result.new(created: receipt.valid?, receipt: receipt)
  end

  class Result
    attr_reader :receipt

    def initialize(created:, receipt:)
      @created = created
      @receipt = receipt
    end

    def created?
      @created
    end
  end
end
