class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.name_search(name)
    where('name ILIKE ?', "%#{name}%") || { data: []}
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

  def self.by_revenue(quantity)
    joins(invoice_items: {invoice: :transactions}).where("invoices.status='shipped' AND transactions.result='success'").group("items.id").select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue").order("revenue DESC").limit(quantity || 10)
  end
end
