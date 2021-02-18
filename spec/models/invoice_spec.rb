require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it "can sort by potential_revenue" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoices = create_list(:invoice, 11, customer: customer, merchant: merchant, status: 'unshipped')
    item = create(:item, merchant: merchant)
    invoices.each_with_index do |invoice, index|
      create(:invoice_item, item: item, invoice: invoice, quantity: (index + 1))
      create(:transaction, invoice: invoice, result: "success")
    end

    expect(Invoice.by_potential_revenue(1).first.potential_revenue).to eq((11 * 1.5))
  end
end
