class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.name_search(name)
    # note- searching for hArU
    where('name LIKE ?', "%#{name}%") || { data: []}
  end

  def self.params_check(params)
    (params[:min_price] || params[:max_price]).nil? ^ params[:name].nil?
  end

  def self.values_search(params)
    items = self
    if min = params[:min_price]
      items = items.where('unit_price >= ?', min)
    end
    if max = params[:max_price]
      items = items.where('unit_price <= ?', max)
    end
    items
  end
end
