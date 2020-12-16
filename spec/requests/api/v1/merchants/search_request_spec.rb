require 'rails_helper'

describe 'Merchants Single-Find API' do
  it 'returns merchant with name query' do
    merchant = Merchant.create!(
      name: 'Kitten Mittens',
      created_at: '2012-03-27 14:53:59',
      updated_at: '2012-03-27 14:53:59'
    )
    create_list(:merchant, 3)

    get "/api/v1/merchants/find?name=mitten"
    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data][:id].to_i).to eq(merchant.id)
    expect(output[:data][:type]).to eq('merchant')
    expect(output[:data][:attributes][:name]).to eq(merchant.name)
  end

  it 'name query case insensitive' do
    merchant = Merchant.create!(
      name: 'Kitten Mittens',
      created_at: '2012-03-27 14:53:59',
      updated_at: '2012-03-27 14:53:59'
    )
    create_list(:merchant, 3)

    get "/api/v1/merchants/find?name=mITten"
    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data][:id].to_i).to eq(merchant.id)
    expect(output[:data][:type]).to eq('merchant')
    expect(output[:data][:attributes][:name]).to eq(merchant.name)
  end

  it 'name query returns only one' do
    merchant = Merchant.create!(
      name: 'Kitten Mittens',
      created_at: '2012-03-27 14:53:59',
      updated_at: '2012-03-27 14:53:59'
    )
    merchant_2 = Merchant.create!(
      name: 'Kitten Parade',
      created_at: '2012-03-27 14:53:59',
      updated_at: '2012-03-27 14:53:59'
    )
    create_list(:merchant, 3)

    get "/api/v1/merchants/find?name=kITten"
    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data][:id].to_i).to eq(merchant.id)
    expect(output[:data][:type]).to eq('merchant')
    expect(output[:data][:attributes][:name]).to eq(merchant.name)
  end

  it 'returns merchant with created_at query' do
    merchant = Merchant.create!(
      name: 'Kitten Mittens',
      created_at: '2012-03-27 14:53:59',
      updated_at: '2012-03-27 14:53:59'
    )
    create_list(:merchant, 3)

    get "/api/v1/merchants/find?created_at=53:59"
    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data][:id].to_i).to eq(merchant.id)
    expect(output[:data][:type]).to eq('merchant')
    expect(output[:data][:attributes][:name]).to eq(merchant.name)
  end

  it 'returns merchant with updated_at query' do
    merchant = Merchant.create!(
      name: 'Kitten Mittens',
      created_at: '2012-03-27 14:53:59',
      updated_at: '2012-03-27 14:53:59'
    )
    create_list(:merchant, 3)

    get "/api/v1/merchants/find?updated_at=:53:"
    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data][:id].to_i).to eq(merchant.id)
    expect(output[:data][:type]).to eq('merchant')
    expect(output[:data][:attributes][:name]).to eq(merchant.name)
  end

  # SAD PATHS!
end

describe 'Merchants Multi-Find API' do
  it 'returns merchants with name query' do
    merchant = Merchant.create!(
      name: 'Kitten Mittens',
      created_at: '2012-03-27 14:53:59',
      updated_at: '2012-03-27 14:53:59'
    )
    merchant_2 = Merchant.create!(
      name: 'Kitten Parade',
      created_at: '2012-03-27 14:53:59',
      updated_at: '2012-03-27 14:53:59'
    )
    create_list(:merchant, 3)

    get "/api/v1/merchants/find_all?name=kitten"
    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data].count).to eq(2)
    expect(output[:data][0][:id].to_i).to eq(merchant.id)
    expect(output[:data][1][:id].to_i).to eq(merchant_2.id)
    expect(output[:data][0][:type]).to eq('merchant')
    expect(output[:data][1][:type]).to eq('merchant')
    expect(output[:data][0][:attributes][:name]).to eq(merchant.name)
    expect(output[:data][1][:attributes][:name]).to eq(merchant_2.name)
  end

  it 'returns merchants with name query' do
    merchant = Merchant.create!(
      name: 'Kitten Mittens',
      created_at: '2012-03-27 14:53:59',
      updated_at: '2012-03-27 14:53:59'
    )
    merchant_2 = Merchant.create!(
      name: 'Kitten Parade',
      created_at: '2012-03-27 14:53:59',
      updated_at: '2012-03-27 14:53:59'
    )
    create_list(:merchant, 3)

    get "/api/v1/merchants/find_all?created_at=2012-03-27"
    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data].count).to eq(2)
    expect(output[:data][0][:id].to_i).to eq(merchant.id)
    expect(output[:data][1][:id].to_i).to eq(merchant_2.id)
    expect(output[:data][0][:type]).to eq('merchant')
    expect(output[:data][1][:type]).to eq('merchant')
    expect(output[:data][0][:attributes][:name]).to eq(merchant.name)
    expect(output[:data][1][:attributes][:name]).to eq(merchant_2.name)
  end

  it 'returns merchants with name query' do
    merchant = Merchant.create!(
      name: 'Kitten Mittens',
      created_at: '2012-03-27 14:53:59',
      updated_at: '2012-03-27 14:53:59'
    )
    merchant_2 = Merchant.create!(
      name: 'Kitten Parade',
      created_at: '2012-03-27 14:53:59',
      updated_at: '2012-03-27 14:53:59'
    )
    create_list(:merchant, 3)

    get "/api/v1/merchants/find_all?updated_at=53:59"
    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data].count).to eq(2)
    expect(output[:data][0][:id].to_i).to eq(merchant.id)
    expect(output[:data][1][:id].to_i).to eq(merchant_2.id)
    expect(output[:data][0][:type]).to eq('merchant')
    expect(output[:data][1][:type]).to eq('merchant')
    expect(output[:data][0][:attributes][:name]).to eq(merchant.name)
    expect(output[:data][1][:attributes][:name]).to eq(merchant_2.name)
  end

  # SAD PATHS!
end
