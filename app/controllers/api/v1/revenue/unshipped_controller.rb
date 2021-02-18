class Api::V1::Revenue::UnshippedController < ApplicationController
  def index
    render json: PotentialRevenueSerializer.new(Invoice.by_potential_revenue(params[:quantity]))
  end
end