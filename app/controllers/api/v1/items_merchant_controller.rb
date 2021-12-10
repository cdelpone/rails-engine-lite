class Api::V1::ItemsMerchantController < ApplicationController
  def show
    if Item.exists?(params[:id])
      # merchant = Merchant.find_by(params[:merchant_id])
      merchant = Item.find(params[:id]).merchant
      render json: MerchantSerializer.new(merchant)
    else
      render json: ItemSerializer.item_not_found, status: 404
    end
  end
end
