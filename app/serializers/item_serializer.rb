class ItemSerializer
  def self.format_items(page, per_page)
    if items = items(page, per_page)
      {
        data: items.map do |item|
          {
            id: item.id,
            attributes: {
              name: item.name,
              description: item.description,
              unit_price: item.unit_price,
              merchant_id: item.merchant_id
            }
          }
        end
      }
    else
      { data: [] }
    end
  end

  private

  def self.items(page, per_page)
    page = 1 if page.nil?
    per_page = 20 if per_page.nil?
    Item.all[((page.to_i - 1) * per_page.to_i)..(page.to_i * per_page.to_i - 1)]
  end
end