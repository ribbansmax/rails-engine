class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.search(name)
    where('name LIKE ?', "%#{name}%") || {}
  end
end
