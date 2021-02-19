class Api::V1::Merchants::SearchController < ApplicationController
  def index
    merchants = Merchant.search_all_by_name(params[:name])
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.order(name: :asc).search_one_by_name(params[:name])
    render json: MerchantSerializer.new(merchant)
  end

end