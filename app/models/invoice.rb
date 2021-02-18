class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :transactions, dependent: :destroy

  def self.by_potential_revenue(quantity)
    joins(:invoice_items, :transactions).where("invoices.status!='shipped' AND transactions.result='success'").group("invoices.id").select("invoices.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue").order("revenue DESC").limit(quantity || 10)
  end
end
