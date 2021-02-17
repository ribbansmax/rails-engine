require 'rails_helper'

describe "Item API" do
  it "sends an item" do
    merchant = create(:merchant)
    item1 = create(:item, merchant: merchant)

    get "/api/v1/items/#{item1.id}"

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

  it "can update an existing item" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    new_params = attributes_for(:item, merchant_id: merchant.id)
    headers = {"CONTENT_TYPE" => "application/json"}

    patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: new_params)

    expect(response).to be_successful
    expect(Item.last.name).to eq(new_params[:name])
    expect(Item.last.description).to eq(new_params[:description])
    expect(Item.last.unit_price).to eq(new_params[:unit_price])
    expect(Item.last.merchant_id).to eq(new_params[:merchant_id])


    patch "/api/v1/items/#{item.id + 1}", headers: headers, params: JSON.generate(item: new_params)

    expect(response).not_to be_successful
  end

  it "can delete an existing item" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    delete "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate(item: {id: item.id})

    expect(response).to be_successful
    expect(Item.last).to eq(nil)
  end

  it "can give merchant data" do
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful
    merchant_info = JSON.parse(response.body, symbolize_names: true)
    expect(merchant_info[:data][:attributes][:name]).to eq(merchant.name)
  end
end