class Api::V1::Merchants::LogicController < ApplicationController
  def most_revenue
    render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity]))
  end

  def most_items
    render json: MerchantSerializer.new(Merchant.most_items(params[:quantity]))
  end

  # def revenue
  #   total = Merchant.revenue(params[:start], params[:end])
  #   render json: RevenueSerializer.new(total)
  # end
end