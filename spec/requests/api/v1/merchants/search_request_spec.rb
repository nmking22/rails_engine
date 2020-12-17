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

  it 'returns merchants with created_at query' do
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

  it 'returns merchants with updated_at query' do
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

describe 'Business Intelligence API' do
  before :each do
    @merchant_1 = Merchant.create(name: "Bob's Burgers")
    @merchant_2 = Merchant.create(name: "Jimmy Pesto's Pizzeria")
    @merchant_3 = Merchant.create(name: 'A Taco Truck')
    @item_1 = Item.create(
      name: 'Burger',
      description: 'Good',
      unit_price: 5.00,
      merchant: @merchant_1
    )
    @item_2 = Item.create(
      name: 'Pizza',
      description: 'Evil',
      unit_price: 10.00,
      merchant: @merchant_2
    )
    @item_3 = Item.create(
      name: 'Taco',
      description: 'Overpriced',
      unit_price: 50.00,
      merchant: @merchant_3
    )
    @customer = Customer.create(
      first_name: 'John Michael',
      last_name: 'Vincent'
    )
    @invoice_1 = Invoice.create(
      customer: @customer,
      merchant: @merchant_1,
      status: 'shipped'
    )
    @invoice_2 = Invoice.create(
      customer: @customer,
      merchant: @merchant_2,
      status: 'shipped'
    )
    @invoice_3 = Invoice.create(
      customer: @customer,
      merchant: @merchant_3,
      status: 'packaged'
    )
    @invoice_4 = Invoice.create(
      customer: @customer,
      merchant: @merchant_3,
      status: 'shipped'
    )
    @invoice_item_1 = InvoiceItem.create(
      item: @item_1,
      invoice: @invoice_1,
      quantity: 500,
      unit_price: 5.00
    )
    @invoice_item_2 = InvoiceItem.create(
      item: @item_2,
      invoice: @invoice_2,
      quantity: 50,
      unit_price: 10.00
    )
    @invoice_item_3 = InvoiceItem.create(
      item: @item_3,
      invoice: @invoice_3,
      quantity: 99999,
      unit_price: 50.00
    )
    @invoice_item_4 = InvoiceItem.create(
      item: @item_3,
      invoice: @invoice_4,
      quantity: 99999,
      unit_price: 50.00
    )
    @transaction_1 = Transaction.create(
      invoice: @invoice_1,
      credit_card_number: 12345,
      credit_card_expiration_date: 04/23,
      result: 'success'
    )
    @transaction_2 = Transaction.create(
      invoice: @invoice_2,
      credit_card_number: 12345,
      credit_card_expiration_date: 04/23,
      result: 'success'
    )
    @transaction_3 = Transaction.create(
      invoice: @invoice_3,
      credit_card_number: 12345,
      credit_card_expiration_date: 04/23,
      result: 'success'
    )
    @transaction_4 = Transaction.create(
      invoice: @invoice_4,
      credit_card_number: 12345,
      credit_card_expiration_date: 04/23,
      result: 'failed'
    )
  end

  it 'returns merchants with most revenue' do
    get '/api/v1/merchants/most_revenue?quantity=2'

    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data].count).to eq(2)
    expect(output[:data][0][:id].to_i).to eq(@merchant_1.id)
    expect(output[:data][1][:id].to_i).to eq(@merchant_2.id)
    expect(output[:data][0][:type]).to eq('merchant')
    expect(output[:data][1][:type]).to eq('merchant')
    expect(output[:data][0][:attributes][:name]).to eq(@merchant_1.name)
    expect(output[:data][1][:attributes][:name]).to eq(@merchant_2.name)
  end

  it 'returns merchants who sold the most items' do
    get '/api/v1/merchants/most_items?quantity=2'

    expect(response).to be_successful
    output = JSON.parse(response.body, symbolize_names: true)

    expect(output[:data].count).to eq(2)
    expect(output[:data][0][:id].to_i).to eq(@merchant_1.id)
    expect(output[:data][1][:id].to_i).to eq(@merchant_2.id)
    expect(output[:data][0][:type]).to eq('merchant')
    expect(output[:data][1][:type]).to eq('merchant')
    expect(output[:data][0][:attributes][:name]).to eq(@merchant_1.name)
    expect(output[:data][1][:attributes][:name]).to eq(@merchant_2.name)
  end
end
