class Api::V1::Items::FindAllController < ApplicationController
  def index
    if params[:name].present?
      item = Item.search_by_name(params[:name])
      render json: ItemSerializer.new(item)
    else
      render json: {
                    errors: {
                            message: "Looks like something is missing"
                            }
                    }, status: 400
    end
  end
end
