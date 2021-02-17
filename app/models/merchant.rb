class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.search(name)
    where('name LIKE ?', "%#{name}%").first
  end
end
