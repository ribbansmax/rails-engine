require 'rails_helper'

describe "Item API" do
  it "sends an item" do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)

    get "/api/v1/items/#{item.id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)

    item = item[:data]

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

  it "can create a new item" do
    merchant = create(:merchant)
    item_params = attributes_for(:item, merchant_id: merchant.id)
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)

    item = Item.last

    expect(response).to be_successful
    expect(item.name).to eq(item_params[:name])
    expect(item.description).to eq(item_params[:description])
    expect(item.unit_price).to eq(item_params[:unit_price])
    expect(item.merchant_id).to eq(item_params[:merchant_id])
  end
end