class MerchantSerializer
  include JSONAPI::Serializer
  attributes :name
  has_many :items, :invoices
end
