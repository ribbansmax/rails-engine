class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(items)
  end
  
  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    render json: ItemSerializer.new(Item.create!(item_params)), status: :created
  end

  def update
    item = Item.find(params[:id])
    item.update!(item_params)
    render json: ItemSerializer.new(item)
  end

  def destroy
    render json: Item.find(params[:id]).destroy
  end

  def merchant_show
    render json: MerchantSerializer.new(Merchant.find(Item.find(params[:id]).merchant_id))
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

  def items
    page = params[:page] || 1
    per_page = params[:per_page] || 20
    Item.all[((page.to_i - 1) * per_page.to_i)..(page.to_i * per_page.to_i - 1)] || []
  end
end