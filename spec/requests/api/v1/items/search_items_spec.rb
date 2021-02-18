require 'rails_helper'

describe 'Item find_all' do
  it 'should return all items that match' do
    merchant = create(:merchant)
    item = create(:item, name: 'test', unit_price: 100, merchant: merchant)
    item2 = create(:item, name: 'test1', unit_price: 10, merchant: merchant)
    item3 = create(:item, name: 'test2', unit_price: 1, merchant: merchant)

    get "/api/v1/items/find_all?name=test"

    expect(response).to be_successful
    item_info = JSON.parse(response.body, symbolize_names: true)
    expect(item_info[:data].length).to eq(3)

    get "/api/v1/items/find_all?name=1"

    expect(response).to be_successful
    item_info = JSON.parse(response.body, symbolize_names: true)

    expect(item_info[:data].first[:attributes][:name]).to eq(item2.name)

    get "/api/v1/items/find_all?min_price=10"

    expect(response).to be_successful
    item_info = JSON.parse(response.body, symbolize_names: true)
    expect(item_info[:data].length).to eq(2)

    get "/api/v1/items/find_all?max_price=10"

    expect(response).to be_successful
    item_info = JSON.parse(response.body, symbolize_names: true)
    expect(item_info[:data].length).to eq(2)

    get "/api/v1/items/find_all?min_price=10&max_price=50"

    expect(response).to be_successful
    item_info = JSON.parse(response.body, symbolize_names: true)
    expect(item_info[:data].length).to eq(1)

    get "/api/v1/items/find_all?min_price=10&name=test"

    expect(response).not_to be_successful
  end
end