class Api::V1::Items::SearchController < ApplicationController
  def index
    if Item.params_check(params)
      if params[:name]
        items = Item.name_search(params[:name].downcase)
      else
        items = Item.values_search(params)
      end
      render json: ItemSerializer.new(items)
    else
      render json: {"error" => {}}, status: 404
    end
  end
end