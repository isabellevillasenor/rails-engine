class Api::V1::Items::SearchController < ApplicationController
  def index
    items = Item.search_all_by_name(params[:name])
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.order(name: :asc).search_one_by_name(params[:name])
    render json: ItemSerializer.new(item)
  end
end