require 'rails_helper'

describe "Merchant API" do
  it "sends a merchant" do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body, symbolize_names: true)

    merchant_info = merchant_info[:data]

    expect(merchant_info).to have_key(:id)
    expect(merchant_info[:id]).to be_a(String)

    expect(merchant_info).to have_key(:attributes)
    expect(merchant_info[:attributes]).to be_a(Hash)

    attributes = merchant_info[:attributes]

    expect(attributes).to have_key(:name)
    expect(attributes[:name]).to be_a(String)
  end

  it "sends the merchants revenue" do
    merchant = create(:merchant)
    customer = create(:customer)
    items = create_list(:item, 11, merchant: merchant)
    invoice = create(:invoice, merchant: merchant, customer: customer)
    transaction = create(:transaction, invoice: invoice, result: "success")
    items.each_with_index do |item, index|
      create(:invoice_item, item: item, invoice: invoice, quantity: (20 - index))
    end

    get "/api/v1/revenue/merchants/#{merchant.id}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body, symbolize_names: true)

    expect(merchant_info.length).to eq(1)

    expect(merchant_info[:data][:attributes][:revenue]).to eq(merchant.total_revenue.revenue)
  end
end