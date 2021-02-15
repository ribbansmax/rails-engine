class MerchantSerializer
  def self.format_merchants(page, per_page)
    if merchants = merchants(page, per_page)
      {
        data: merchants.map do |merchant|
          {
            id: merchant.id,
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

  private

  def self.merchants(page, per_page)
    page = 1 if page.nil?
    per_page = 20 if per_page.nil?
    Merchant.all[((page.to_i - 1) * per_page.to_i)..(page.to_i * per_page.to_i - 1)]
  end
end
