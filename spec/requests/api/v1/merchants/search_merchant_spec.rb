require 'rails_helper'

describe 'Merchant find_one' do
  it 'should return the first merchant' do
    merchant = create(:merchant, name: 'test')
    merchant2 = create(:merchant, name: 'test1')
    merchant3 = create(:merchant, name: 'test2')

    get "/api/v1/merchants/find_one?name=test"

    expect(response).to be_successful
    merchant_info = JSON.parse(response.body, symbolize_names: true)
    expect(merchant_info[:data][:attributes][:name]).to eq(merchant.name)

    get "/api/v1/merchants/find_one?name=1"

    expect(response).to be_successful
    merchant_info = JSON.parse(response.body, symbolize_names: true)
    expect(merchant_info[:data][:attributes][:name]).to eq(merchant2.name)
  end
end