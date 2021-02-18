require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    merchants[:data].each do |merchant|

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_a(String)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to be_a(Hash)

      attributes = merchant[:attributes]

      expect(attributes).to have_key(:name)
      expect(attributes[:name]).to be_a(String)
    end
  end

  it "takes a page number and only returns requested results" do
    create_list(:merchant, 41)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].length).to eq(20)

    get '/api/v1/merchants?page=2'

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].length).to eq(20)

    get '/api/v1/merchants?page=3'

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].length).to eq(1)

    get '/api/v1/merchants?page=2&per_page=30'

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].length).to eq(11)

    get '/api/v1/merchants?page=2&per_page=300'

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].length).to eq(0)
  end

  it "sends the top x merchants by revenue" do
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    customer = create(:customer)
    items = []
    items << create_list(:item, 11, merchant: merchant)
    items << create_list(:item, 11, merchant: merchant2)
    items << create_list(:item, 11, merchant: merchant3)
    items.flatten!
    invoice = create(:invoice, merchant: merchant, customer: customer)
    invoice2 = create(:invoice, merchant: merchant2, customer: customer)
    invoice3 = create(:invoice, merchant: merchant3, customer: customer)
    transaction = create(:transaction, invoice: invoice, result: "success")
    transaction2 = create(:transaction, invoice: invoice2, result: "success")
    transaction3 = create(:transaction, invoice: invoice3, result: "success")
    items.each_with_index do |item, index|
      create(:invoice_item, item: item, invoice: invoice, quantity: (20 - index))
      create(:invoice_item, item: item, invoice: invoice2, quantity: (30 - index))
      create(:invoice_item, item: item, invoice: invoice3, quantity: (25 - index))
    end

    get "/api/v1/revenue/merchants"

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].length).to eq(3)

    get "/api/v1/revenue/merchants?quantity=1"

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].length).to eq(1)
    expect(merchants[:data].first[:attributes][:name]).to eq(merchant2.name)
  end
end