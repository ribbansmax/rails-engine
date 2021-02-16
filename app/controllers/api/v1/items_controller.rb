class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.format_items(params[:page], params[:per_page])
  end

  def show
    render json: ItemSerializer.format_item(params[:id])
  end
end