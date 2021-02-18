require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'class methods' do
    it "can search by name" do
      merchant = create(:merchant)
      create_list(:item, 10, merchant: merchant)
      item = create(:item, merchant: merchant, name: "Bing Crosby's Christmas Album")
      item2 = create(:item, merchant: merchant, name: "Generic Christmas Album")

      expect(Item.name_search("Bing")).to eq([item])
      expect(Item.name_search("cRosB")).to eq([item])
      expect(Item.name_search("Christmas Album")).to eq([item, item2])
    end
  end
end
