class Api::V1::Merchants::SearchController < ApplicationController
  def find_all
    search_params.each do |key, value|
      @merchants = Merchant.where("lower(#{key}) like ?", "%#{value.downcase}%")
    end
    render json: MerchantSerializer.new(@merchants)
  end

  def find
    search_params.each do |key, value|
      @merchant = Merchant.where("lower(#{key}) like ?", "%#{value.downcase}%")[0]
    end
    render json: MerchantSerializer.new(@merchant)
  end

  def most_revenue
    quantity = params[:quantity].to_i
    merchants = Merchant.most_revenue(quantity)
    render json: MerchantSerializer.new(merchants)
  end

  def most_items
    quantity = params[:quantity].to_i
    merchants = Merchant.most_items(quantity)
    render json: MerchantSerializer.new(merchants)
  end

  def revenue
    merchant = Merchant.find(params[:id])
    render json: RevenueSerializer.new(merchant.revenue)
  end

  def revenue_across_dates
    start_date = params[:start]
    end_date = params[:end]
    revenue = Merchant.revenue_across_dates(start_date, end_date)

    render json: RevenueSerializer.new(revenue)
  end

  private

    def search_params
      params.permit(:name, :created_at, :updated_at)
    end
end
