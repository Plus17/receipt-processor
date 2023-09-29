class ReceiptsController < ApplicationController
  skip_before_action :verify_authenticity_token
  # GET /receipts/1 or /receipts/1.json
  def show
    @receipt = Receipt.find(params[:id])

    respond_to do |format|
      format.json { render json: {points: @receipt.points} }
    end
  end

  # POST /receipts or /receipts.json
  def create
    @receipt = Receipt.new(data: receipt_params)

    result = ReceiptProcessor.new.create_receipt(@receipt)

    respond_to do |format|
      if result.created?
        format.json { render json: {id: result.receipt.id}, status: :ok }
      else
        @receipt = result.receipt
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def receipt_params
    params.permit(:retailer, :purchaseDate, :purchaseTime, :total, items: [%i[shortDescription price]])
  end
end
