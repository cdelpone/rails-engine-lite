class Api::V1::Merchants::FindController < ApplicationController
  def show
    if params[:name].present?
      merchant = Merchant.search_by_name(params[:name])
      render json: MerchantSerializer.new(merchant)
    else
      render json: {:errors=>{:message=>"Looks like something is missing"}}, status: 400
    end
  end
end
