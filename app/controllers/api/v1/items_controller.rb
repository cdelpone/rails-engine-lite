class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    # item = Item.find(params[:id])
    # if item
    if Item.exists?(params[:id])
      item = Item.find(params[:id])
      render json: ItemSerializer.new(item)
    else
      render json: ItemSerializer.item_not_found, status: 404
    end
  end

  def create
    item = Item.create!(item_params)
    render json: ItemSerializer.new(item), status: 201
  end

  def destroy
    Item.find(params[:id]).destroy
  end

  def update
    item = Item.update(params[:id], item_params)
    render json: ItemSerializer.new(item)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

  def invalid_params
    if params[:merchant_id].class == String
      render json: { error: 'Bad Request' }, status: 400
    end
  end
end
