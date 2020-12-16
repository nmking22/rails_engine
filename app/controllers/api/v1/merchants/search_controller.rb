class Api::V1::Merchants::SearchController < ApplicationController
  def index
    search_params.each do |key, value|
      @merchants = Merchant.where("lower(#{key}) like ?", "%#{value.downcase}%")
    end
    render json: MerchantSerializer.new(@merchants)
  end

  def show
    search_params.each do |key, value|
      @merchant = Merchant.where("lower(#{key}) like ?", "%#{value.downcase}%")[0]
    end
    render json: MerchantSerializer.new(@merchant)
  end

  private

    def search_params
      params.permit(:name, :created_at, :updated_at)
    end
end
