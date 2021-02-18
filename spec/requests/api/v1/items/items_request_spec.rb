require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    items[:data].each do |item|

      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_a(Hash)

      attributes = item[:attributes]

      expect(attributes).to have_key(:name)
      expect(attributes[:name]).to be_a(String)

      expect(attributes).to have_key(:description)
      expect(attributes[:description]).to be_a(String)

      expect(attributes).to have_key(:unit_price)
      expect(attributes[:unit_price]).to be_a(Float)

      expect(attributes).to have_key(:merchant_id)
      expect(attributes[:merchant_id]).to be_an(Integer)
    end

    get '/api/v1/items?page=2'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data]).to eq([])
  end

  it "sends the top x items by revenue" do
    merchant = create(:merchant)
    customer = create(:customer)
    items = create_list(:item, 11)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    transaction = create(:transaction, invoice: invoice, result: "success")
    items.each_with_index do |item, index|
      create(:invoice_item, item: item, invoice: invoice, quantity: (20 - index))
    end

    get "/api/v1/items/revenue"

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].length).to eq(10)

    get "/api/v1/items/revenue?quantity=7"

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].length).to eq(7)
  end
end