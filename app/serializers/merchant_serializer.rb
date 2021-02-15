class MerchantSerializer
  def self.format_merchants(page, per_page)
    if merchants = merchants(page, per_page)
      {
        data: merchants.map do |merchant|
          {
            id: merchant.id.to_s,
            type: "merchant",
            attributes: {
              name: merchant.name
            }
          }
        end
      }
    else
      { data: [] }
    end
  end

  def self.format_merchant(id)
    merchant = Merchant.find(id)
    {
      data:
      {
        id: merchant.id.to_s,
        type: "merchant",
        attributes: {
          name: merchant.name
        }
      }
    }
  end

  def self.format_items(id)
    merchant = Merchant.find(id)
    {
      data: merchant.items.map do |item|
        {
          id: item.id.to_s,
          type: "item",
          attributes: {
            name: item.name,
            description: item.description,
            unit_price: item.unit_price,
            merchant_id: item.merchant_id
          }
        }
      end
    }
  end

  private

  def self.merchants(page, per_page)
    page = 1 if page.nil?
    per_page = 20 if per_page.nil?
    Merchant.all[((page.to_i - 1) * per_page.to_i)..(page.to_i * per_page.to_i - 1)]
  end
end
