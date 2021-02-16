class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.format_items(params[:page], params[:per_page])
  end
  
  def show
    render json: ItemSerializer.format_item(params[:id])
  end

  def create
    render json: Item.create!(item_params)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end