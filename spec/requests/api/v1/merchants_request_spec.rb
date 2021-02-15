require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    merchants[:data].each do |merchant|

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(Integer)

      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to be_a(Hash)

      attributes = merchant[:attributes]

      expect(attributes).to have_key(:name)
      expect(attributes[:name]).to be_a(String)
    end
  end

  it "takes a page number and only returns requested results" do
    create_list(:merchant, 41)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].length).to eq(20)

    get '/api/v1/merchants?page=2'

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].length).to eq(20)

    get '/api/v1/merchants?page=3'

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].length).to eq(1)

    get '/api/v1/merchants?page=2&per_page=30'

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].length).to eq(11)

    get '/api/v1/merchants?page=2&per_page=300'

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].length).to eq(0)
  end
end