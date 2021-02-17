class Api::V1::Items::SearchController < ApplicationController
  def index
    items = Item.search(params[:name].downcase)
    render json: ItemSerializer.new(items)
  end
end