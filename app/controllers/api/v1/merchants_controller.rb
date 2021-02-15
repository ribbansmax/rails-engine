class Api::V1::MerchantsController < ApplicationController
  def index
    render json: MerchantSerializer.format_merchants(params[:page], params[:perPage])
  end
end