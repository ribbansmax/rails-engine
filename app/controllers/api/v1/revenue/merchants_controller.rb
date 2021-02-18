class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    render json: MerchantRevenueSerializer.new(Merchant.by_revenue(params[:quantity]))
  end
end