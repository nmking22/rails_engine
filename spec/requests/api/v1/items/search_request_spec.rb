require 'rails_helper'

describe 'Items Single-Find API' do
  before :each do
    @merchant = create(:merchant)
    @item = Item.create!(
      name: 'Kitten Mittens',
      description: "Finally there's an elegant comfortable mitten for cats",
      unit_price: 19.99,
      created_at: '2012-03-27 14:53:59',
      updated_at: '2012-03-27 14:53:59',
      merchant: @merchant
    )
    create_list(:item, 3)
  end

  it 'returns item with name query' do
    get "/api/v1/items/find?name=miTTen"
    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data][:id].to_i).to eq(@item.id)
    expect(output[:data][:type]).to eq('item')
    expect(output[:data][:attributes][:name]).to eq(@item.name)
  end

  it 'name query returns only one' do
    item_2 = Item.create!(
      name: 'Kitten Pajamas',
      description: "Finally there's an elegant comfortable pajama for cats",
      unit_price: 9000.01,
      created_at: '2012-03-27 14:53:59',
      updated_at: '2012-03-27 14:53:59',
      merchant: @merchant
    )

    get "/api/v1/items/find?name=kITten"
    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data][:id].to_i).to eq(@item.id)
    expect(output[:data][:type]).to eq('item')
    expect(output[:data][:attributes][:name]).to eq(@item.name)
  end

  it 'returns item with created_at query' do
    get "/api/v1/items/find?created_at=53:59"
    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data][:id].to_i).to eq(@item.id)
    expect(output[:data][:type]).to eq('item')
    expect(output[:data][:attributes][:name]).to eq(@item.name)
  end

  it 'returns item with updated_at query' do
    get "/api/v1/items/find?updated_at=:53:"
    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data][:id].to_i).to eq(@item.id)
    expect(output[:data][:type]).to eq('item')
    expect(output[:data][:attributes][:name]).to eq(@item.name)
  end

  it 'returns item with description query' do
    get "/api/v1/items/find?description=finALLy"
    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data][:id].to_i).to eq(@item.id)
    expect(output[:data][:type]).to eq('item')
    expect(output[:data][:attributes][:name]).to eq(@item.name)
  end

  it 'returns item with unit_price query' do
    get "/api/v1/items/find?unit_price=19.99"
    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data][:id].to_i).to eq(@item.id)
    expect(output[:data][:type]).to eq('item')
    expect(output[:data][:attributes][:name]).to eq(@item.name)
  end

  it 'returns item with merchant_id query' do
    get "/api/v1/items/find?merchant_id=#{@item.merchant_id}"
    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data][:id].to_i).to eq(@item.id)
    expect(output[:data][:type]).to eq('item')
    expect(output[:data][:attributes][:name]).to eq(@item.name)
  end

  # SAD PATHS!
end

describe 'Items Multi-Find API' do
  before :each do
    @merchant = create(:merchant)
    @item = Item.create!(
      name: 'Kitten Mittens',
      description: "Finally there's an elegant comfortable mitten for cats",
      unit_price: 19.99,
      created_at: '2012-03-27 14:53:59',
      updated_at: '2012-03-27 14:53:59',
      merchant: @merchant
    )
    @item_2 = Item.create!(
      name: 'Kitten Pajamas',
      description: "Finally there's an elegant comfortable pajama for cats",
      unit_price: 19.99,
      created_at: '2012-03-27 14:53:59',
      updated_at: '2012-03-27 14:53:59',
      merchant: @merchant
    )

    create_list(:item, 3)
  end

  it 'returns items with name query' do
    get "/api/v1/items/find_all?name=kiTTen"
    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data].count).to eq(2)
    expect(output[:data][0][:id].to_i).to eq(@item.id)
    expect(output[:data][1][:id].to_i).to eq(@item_2.id)
    expect(output[:data][0][:type]).to eq('item')
    expect(output[:data][1][:type]).to eq('item')
    expect(output[:data][0][:attributes][:name]).to eq(@item.name)
    expect(output[:data][1][:attributes][:name]).to eq(@item_2.name)
    expect(output[:data][0][:attributes][:description]).to eq(@item.description)
    expect(output[:data][1][:attributes][:description]).to eq(@item_2.description)
    expect(output[:data][0][:attributes][:unit_price]).to eq(@item.unit_price)
    expect(output[:data][1][:attributes][:unit_price]).to eq(@item_2.unit_price)
    expect(output[:data][0][:attributes][:merchant_id]).to eq(@item.merchant_id)
    expect(output[:data][1][:attributes][:merchant_id]).to eq(@item_2.merchant_id)
  end

  it 'returns items with description query' do
    get "/api/v1/items/find_all?description=finALLy"
    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data].count).to eq(2)
    expect(output[:data][0][:id].to_i).to eq(@item.id)
    expect(output[:data][1][:id].to_i).to eq(@item_2.id)
    expect(output[:data][0][:type]).to eq('item')
    expect(output[:data][1][:type]).to eq('item')
    expect(output[:data][0][:attributes][:name]).to eq(@item.name)
    expect(output[:data][1][:attributes][:name]).to eq(@item_2.name)
    expect(output[:data][0][:attributes][:description]).to eq(@item.description)
    expect(output[:data][1][:attributes][:description]).to eq(@item_2.description)
    expect(output[:data][0][:attributes][:unit_price]).to eq(@item.unit_price)
    expect(output[:data][1][:attributes][:unit_price]).to eq(@item_2.unit_price)
    expect(output[:data][0][:attributes][:merchant_id]).to eq(@item.merchant_id)
    expect(output[:data][1][:attributes][:merchant_id]).to eq(@item_2.merchant_id)
  end

  it 'returns items with unit_price query' do
    get "/api/v1/items/find_all?unit_price=19.99"
    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data].count).to eq(2)
    expect(output[:data][0][:id].to_i).to eq(@item.id)
    expect(output[:data][1][:id].to_i).to eq(@item_2.id)
    expect(output[:data][0][:type]).to eq('item')
    expect(output[:data][1][:type]).to eq('item')
    expect(output[:data][0][:attributes][:name]).to eq(@item.name)
    expect(output[:data][1][:attributes][:name]).to eq(@item_2.name)
    expect(output[:data][0][:attributes][:description]).to eq(@item.description)
    expect(output[:data][1][:attributes][:description]).to eq(@item_2.description)
    expect(output[:data][0][:attributes][:unit_price]).to eq(@item.unit_price)
    expect(output[:data][1][:attributes][:unit_price]).to eq(@item_2.unit_price)
    expect(output[:data][0][:attributes][:merchant_id]).to eq(@item.merchant_id)
    expect(output[:data][1][:attributes][:merchant_id]).to eq(@item_2.merchant_id)
  end

  it 'returns items with created_at query' do
    get "/api/v1/items/find_all?created_at=03-27"
    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data].count).to eq(2)
    expect(output[:data][0][:id].to_i).to eq(@item.id)
    expect(output[:data][1][:id].to_i).to eq(@item_2.id)
    expect(output[:data][0][:type]).to eq('item')
    expect(output[:data][1][:type]).to eq('item')
    expect(output[:data][0][:attributes][:name]).to eq(@item.name)
    expect(output[:data][1][:attributes][:name]).to eq(@item_2.name)
    expect(output[:data][0][:attributes][:description]).to eq(@item.description)
    expect(output[:data][1][:attributes][:description]).to eq(@item_2.description)
    expect(output[:data][0][:attributes][:unit_price]).to eq(@item.unit_price)
    expect(output[:data][1][:attributes][:unit_price]).to eq(@item_2.unit_price)
    expect(output[:data][0][:attributes][:merchant_id]).to eq(@item.merchant_id)
    expect(output[:data][1][:attributes][:merchant_id]).to eq(@item_2.merchant_id)
  end

  it 'returns items with updated_at query' do
    get "/api/v1/items/find_all?updated_at=03-27"
    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data].count).to eq(2)
    expect(output[:data][0][:id].to_i).to eq(@item.id)
    expect(output[:data][1][:id].to_i).to eq(@item_2.id)
    expect(output[:data][0][:type]).to eq('item')
    expect(output[:data][1][:type]).to eq('item')
    expect(output[:data][0][:attributes][:name]).to eq(@item.name)
    expect(output[:data][1][:attributes][:name]).to eq(@item_2.name)
    expect(output[:data][0][:attributes][:description]).to eq(@item.description)
    expect(output[:data][1][:attributes][:description]).to eq(@item_2.description)
    expect(output[:data][0][:attributes][:unit_price]).to eq(@item.unit_price)
    expect(output[:data][1][:attributes][:unit_price]).to eq(@item_2.unit_price)
    expect(output[:data][0][:attributes][:merchant_id]).to eq(@item.merchant_id)
    expect(output[:data][1][:attributes][:merchant_id]).to eq(@item_2.merchant_id)
  end

  it 'returns items with merchant_id query' do
    get "/api/v1/items/find_all?merchant_id=#{@merchant.id}"
    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data].count).to eq(2)
    expect(output[:data][0][:id].to_i).to eq(@item.id)
    expect(output[:data][1][:id].to_i).to eq(@item_2.id)
    expect(output[:data][0][:type]).to eq('item')
    expect(output[:data][1][:type]).to eq('item')
    expect(output[:data][0][:attributes][:name]).to eq(@item.name)
    expect(output[:data][1][:attributes][:name]).to eq(@item_2.name)
    expect(output[:data][0][:attributes][:description]).to eq(@item.description)
    expect(output[:data][1][:attributes][:description]).to eq(@item_2.description)
    expect(output[:data][0][:attributes][:unit_price]).to eq(@item.unit_price)
    expect(output[:data][1][:attributes][:unit_price]).to eq(@item_2.unit_price)
    expect(output[:data][0][:attributes][:merchant_id]).to eq(@item.merchant_id)
    expect(output[:data][1][:attributes][:merchant_id]).to eq(@item_2.merchant_id)
  end
  # SAD PATHS!
end
