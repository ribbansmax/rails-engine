require 'rails_helper'

describe "Merchant Items API" do
  it "sends a merchant's items" do
    merchant = create(:merchant)
    items = create_list(:item, 30, merchant: merchant)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful

    merchant_items = JSON.parse(response.body, symbolize_names: true)

    merchant_items = merchant_items[:data]

    merchant_items.each do |merchant_item|
      expect(merchant_item).to have_key(:id)
      expect(merchant_item[:id]).to be_a(String)

      expect(merchant_item).to have_key(:attributes)
      expect(merchant_item[:attributes]).to be_a(Hash)

      attributes = merchant_item[:attributes]

      expect(attributes).to have_key(:name)
      expect(attributes[:name]).to be_a(String)

      expect(attributes).to have_key(:description)
      expect(attributes[:description]).to be_a(String)

      expect(attributes).to have_key(:unit_price)
      expect(attributes[:unit_price]).to be_a(Float)
    end
  end
end