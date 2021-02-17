require 'rails_helper'

describe 'Item find_all' do
  it 'should return all items that match' do
    item = create(:item, name: 'test')
    item2 = create(:item, name: 'test1')
    item3 = create(:item, name: 'test2')

    get "/api/v1/items/find_all?name=test"

    expect(response).to be_successful
    item_info = JSON.parse(response.body, symbolize_names: true)
    expect(item_info[:data].length).to eq(3)

    get "/api/v1/items/find_all?name=1"

    expect(response).to be_successful
    item_info = JSON.parse(response.body, symbolize_names: true)

    expect(item_info[:data].first[:attributes][:name]).to eq(item2.name)
  end
end