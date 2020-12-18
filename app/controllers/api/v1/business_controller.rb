class Api::V1::BusinessController < ApplicationController
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
    revenue = Invoice.revenue_across_dates(start_date, end_date)

    render json: RevenueSerializer.new(revenue)
  end
end
