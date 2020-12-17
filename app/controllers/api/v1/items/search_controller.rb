class Api::V1::Items::SearchController < ApplicationController
  def find_all
    search_params.each do |key, value|
      if key == 'unit_price' || key == 'merchant_id'
        @items = Item.where("#{key} = #{value.to_f}")
      else
        @items = Item.where("lower(#{key}) like ?", "%#{value.downcase}%")
      end
    end
    render json: ItemSerializer.new(@items)
  end


  def find
    search_params.each do |key, value|
      if key == 'unit_price' || key == 'merchant_id'
        @item = Item.where("#{key} = #{value.to_f}")[0]
      else
        @item = Item.where("lower(#{key}) like ?", "%#{value.downcase}%")[0]
      end
    end
    render json: ItemSerializer.new(@item)
  end

  private

    def search_params
      params.permit(:name, :description, :unit_price, :created_at, :updated_at, :merchant_id)
    end
end
