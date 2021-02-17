class Api::V1::Items::SearchController < ApplicationController
  def show
    item = Item.search_by_name(params[:name])
    render json: ItemSerializer.new(item)
  end
end