class Api::V1::MerchantsController < ApplicationController
  # before_action :set_merchant, only: [:update]

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def create
    render json: MerchantSerializer.new(Merchant.create(merchant_params))
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    render json: MerchantSerializer.new(merchant)
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end
  
  def merchant_params
    params.permit(:name)
  end
end