class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(items)
  end
  
  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    render json: Item.create!(item_params)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

  def items
    page = params[:page]
    per_page = params[:per_page]
    page = 1 if page.nil?
    per_page = 20 if per_page.nil?
    Item.all[((page.to_i - 1) * per_page.to_i)..(page.to_i * per_page.to_i - 1)] || []
  end
end