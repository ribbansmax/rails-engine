class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.new(merchants)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def items_index
    render json: ItemSerializer.new(Merchant.find(params[:id]).items)
  end

  private

  def merchants
    page = params[:page]
    per_page = params[:per_page]
    page = 1 if page.nil?
    per_page = 20 if per_page.nil?
    Merchant.all[((page.to_i - 1) * per_page.to_i)..(page.to_i * per_page.to_i - 1)] || []
  end
end