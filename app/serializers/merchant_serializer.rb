class MerchantSerializer
  def self.format_merchants(merchants)
    merchants.map do |merchant|
      {
        data: {
          id: merchant.id,
          attributes: {
            name: merchant.name
          }
        }
      }
    end
  end
end
