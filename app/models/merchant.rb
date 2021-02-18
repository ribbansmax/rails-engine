class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.search(name)
    where('name ILIKE ?', "%#{name}%").first || {}
  end

  def self.by_revenue(quantity)
    joins(invoices: {invoice_items: {invoice: :transactions}}).where("invoices.status='shipped' AND transactions.result='success'").group("merchants.id").select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue").order("revenue DESC").limit(quantity || 10)
  end
end
