class Api::V1::Items::SearchController < ApplicationController
  def index
    if Item.params_check(params) && params
      if params[:name]
        if params[:name].blank?
          binding.pry
          render json: { data: []}
        else
          items = Item.name_search(params[:name])
        end
      else
        items = Item.values_search(params)
      end
      render json: ItemSerializer.new(items)
    else
      render json: {"error" => {}}, status: 404
    end
  end
end