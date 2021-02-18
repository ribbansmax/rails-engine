require 'rails_helper'

describe 'revenue for unshipped orders' do
  it "can return the potential revenue for unshipped orders" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoices = create_list(:invoice, 11, customer: customer, merchant: merchant, status: 'unshipped')
    item = create(:item, merchant: merchant)
    invoices.each_with_index do |invoice, index|
      create(:invoice_item, item: item, invoice: invoice, quantity: (index + 1))
      create(:transaction, invoice: invoice, result: "success")
    end

    get "/api/v1/revenue/unshipped"

    expect(response).to be_successful

    unshipped_info = JSON.parse(response.body, symbolize_names: true)

    expect(unshipped_info[:data].length).to eq(10)

    get "/api/v1/revenue/unshipped?quantity=7"

    unshipped_info = JSON.parse(response.body, symbolize_names: true)

    expect(unshipped_info[:data].length).to eq(7)

    get "/api/v1/revenue/unshipped?quantity=100"

    unshipped_info = JSON.parse(response.body, symbolize_names: true)

    expect(unshipped_info[:data].length).to eq(11)
  end
end