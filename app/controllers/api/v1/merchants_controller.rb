class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.all)
    # if Merchant.exists?(params[:id])
    #   render json: MerchantSerializer.new(Merchant.all)
    # else
    #   render json: MerchantSerializer.merch_not_found, status: 404
    # end
  end

  def show
    # merchant = Merchant.find(params[:id])
    # if merchant
    if Merchant.exists?(params[:id])
      merchant = Merchant.find(params[:id])
      render json: MerchantSerializer.new(merchant)
    else
      render json: MerchantSerializer.merch_not_found, status: 404
    end
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
