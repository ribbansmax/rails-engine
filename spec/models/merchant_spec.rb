require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it "can search for merchant" do
    merchant = create(:merchant, name: 'test')
    merchant2 = create(:merchant, name: 'test1')
    merchant3 = create(:merchant, name: 'test2')

    expect(Merchant.search('test')).to eq(merchant)
    expect(Merchant.search('1')).to eq(merchant2)
    expect(Merchant.search('other words')).to eq({})
  end

  it "can sort by revenue" do
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    customer = create(:customer)
    invoices = create_list(:invoice, 11, customer: customer, merchant: merchant, status: 'shipped')
    invoices2 = create_list(:invoice, 11, customer: customer, merchant: merchant2, status: 'shipped')
    item = create(:item, merchant: merchant)
    item2 = create(:item, merchant: merchant2)
    invoices.each_with_index do |invoice, index|
      create(:invoice_item, item: item, invoice: invoice, quantity: (index + 1))
      create(:transaction, invoice: invoice, result: "success")
    end
    invoices2.each_with_index do |invoice, index|
      create(:invoice_item, item: item, invoice: invoice, quantity: (index + 2))
      create(:transaction, invoice: invoice, result: "success")
    end

    expect(Merchant.by_revenue(1).first).to eq(merchant2)
    expect(Merchant.by_revenue(1).first.revenue).to eq(115.5)
  end

  it "can calculate total revenue" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoices = create_list(:invoice, 11, customer: customer, merchant: merchant, status: 'shipped')
    item = create(:item, merchant: merchant)
    invoices.each_with_index do |invoice, index|
      create(:invoice_item, item: item, invoice: invoice, quantity: (index + 1))
      create(:transaction, invoice: invoice, result: "success")
    end

    expect(merchant.total_revenue.revenue).to eq(99.0)
  end
end
