class Api::V1::Merchants::FindController < ApplicationController
  def show
    merchant = Merchant.search_by_name(params[:name])
    if merchant
      render json: MerchantSerializer.new(merchant)
    else
      render json: MerchantSerializer.merch_not_found, status: 404
    end
  end
end
