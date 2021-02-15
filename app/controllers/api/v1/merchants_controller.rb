class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.format_merchants(params[:page], params[:per_page])
  end

  def show
    render json: MerchantSerializer.format_merchant(params[:id])
  end
end