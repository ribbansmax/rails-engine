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
end
