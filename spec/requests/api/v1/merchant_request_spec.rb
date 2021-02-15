require 'rails_helper'

describe "Merchant API" do
  it "sends a merchant" do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful

    merchant_info = JSON.parse(response.body, symbolize_names: true)

    merchant_info = merchant_info[:data]

    expect(merchant_info).to have_key(:id)
    expect(merchant_info[:id]).to be_an(Integer)

    expect(merchant_info).to have_key(:attributes)
    expect(merchant_info[:attributes]).to be_a(Hash)

    attributes = merchant_info[:attributes]

    expect(attributes).to have_key(:name)
    expect(attributes[:name]).to be_a(String)

    # expect(attributes).to have_key(:description)
    # expect(attributes[:description]).to be_a(String)

    # expect(attributes).to have_key(:unit_price)
    # expect(attributes[:unit_rice]).to be_a(Float)
  end
end