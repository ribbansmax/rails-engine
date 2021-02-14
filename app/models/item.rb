class Item < ApplicationRecord
  belongs_to :merchant_id
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
end
