class Api::V1::Items::RevenueController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.by_revenue(params[:quantity]))
  end
end