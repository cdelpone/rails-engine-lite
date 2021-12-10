class Api::V1::MerchantsItemsController < ApplicationController
  def index
    if Merchant.exists?(params[:id])
      merchant = Merchant.find(params[:id])
      merchant_items = merchant.items
      render json: ItemSerializer.new(merchant_items)
    else
      render json: { error: { message: "This merchant id does not exist" } }, status: 404
      #   render json: MerchantSerializer.merch_not_found, status: 404
    end
  end
end
