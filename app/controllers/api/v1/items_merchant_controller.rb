class Api::V1::ItemsMerchantController < ApplicationController

  def show
    if Merchant.exists?(params[:id])
      merchant = Merchant.find(params[:id])
      merchant_items = merchant.items
      render json: ItemSerializer.new(merchant_items)
    else
      render json: MerchantSerializer.merch_not_found, status: 404
    end
  end
end
