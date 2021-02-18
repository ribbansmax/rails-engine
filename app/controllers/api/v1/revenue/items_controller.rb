class Api::V1::Revenue::ItemsController < ApplicationController
  def index
    render json: ItemRevenueSerializer.new(Item.by_revenue(params[:quantity]))
  end
end