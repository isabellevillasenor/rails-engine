class Api::V1::Merchants::LogicController < ApplicationController
  def most_revenue
    render json: MerchantSerializer.new(Merchant.most_revenue(params[:quantity]))
  end
end