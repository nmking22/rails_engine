require 'rails_helper'

describe 'Items Merchants API' do
  it 'returns merchant associated with item' do
    merchant = create(:merchant)
    merchant_2 = create(:merchant)
    item = create(:item, merchant: merchant)
    get "/api/v1/items/#{item.id}/merchants"

    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data]).to be_a(Hash)
    expect(output[:data][:attributes][:name]).to eq(merchant.name)
  end
end
