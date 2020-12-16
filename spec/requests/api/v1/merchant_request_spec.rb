require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(3)

    merchants[:data].each do |merchant|
      expect(merchant[:attributes]).to have_key(:name)
      expect(merchant[:attributes][:name]).to be_a(String)

      expect(merchant[:attributes]).to have_key(:created_at)
      expect(merchant[:attributes][:created_at]).to be_a(String)

      expect(merchant[:attributes]).to have_key(:updated_at)
      expect(merchant[:attributes][:updated_at]).to be_a(String)
    end
  end

  it "can get one merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(merchant[:data][:attributes]).to have_key(:name)
    expect(merchant[:data][:attributes][:name]).to be_a(String)

    expect(merchant[:data][:attributes]).to have_key(:created_at)
    expect(merchant[:data][:attributes][:created_at]).to be_a(String)

    expect(merchant[:data][:attributes]).to have_key(:updated_at)
    expect(merchant[:data][:attributes][:updated_at]).to be_a(String)
  end

  it "can create a new merchant" do
    merchant_params = ({
                    name: "Bob's Burgers",
                    created_at: '2012-03-27 14:53:59.000000',
                    updated_at: '2012-03-27 14:53:59.000000',
                  })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/merchants", headers: headers, params: JSON.generate(merchant: merchant_params)

    created_merchant = Merchant.last

    expect(response).to be_successful
    expect(created_merchant.name).to eq(merchant_params[:name])
    expect(created_merchant.created_at).to eq(merchant_params[:created_at])
    expect(created_merchant.updated_at).to eq(merchant_params[:updated_at])
  end

  it "can update an existing merchant" do
    id = create(:merchant).id
    previous_name = Merchant.last.name
    merchant_params = { name: "Jimmy Pesto's Pizzeria" }
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/merchants/#{id}", headers: headers, params: JSON.generate({merchant: merchant_params})
    merchant = Merchant.find_by(id: id)

    expect(response).to be_successful
    expect(merchant.name).to_not eq(previous_name)
    expect(merchant.name).to eq("Jimmy Pesto's Pizzeria")
  end

  it "can destroy an merchant" do
    merchant = create(:merchant)

    expect(Merchant.count).to eq(1)

    delete "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful
    expect(Merchant.count).to eq(0)
    expect{Merchant.find(merchant.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end
