require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    merchants.each do |merchant|

      expect(merchant).to have_key(:data)
      expect(merchant[:data]).to be_a(Hash)

      data = merchant[:data]

      expect(data).to have_key(:id)
      expect(data[:id]).to be_an(Integer)

      expect(data).to have_key(:attributes)
      expect(data[:attributes]).to be_a(Hash)

      attributes = data[:attributes]

      expect(attributes).to have_key(:name)
      expect(attributes[:name]).to be_a(String)
    end
  end
end