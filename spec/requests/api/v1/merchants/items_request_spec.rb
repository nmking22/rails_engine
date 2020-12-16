require 'rails_helper'

describe 'Merchants Items API' do
  it 'returns items associated with merchant' do
    merchant = create(:merchant, :with_items)
    item = create(:item)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(2)
    expect(items[:data]).to_not include(item)
  end
end
