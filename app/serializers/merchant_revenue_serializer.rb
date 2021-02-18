class MerchantRevenueSerializer
  include JSONAPI::Serializer
  attributes :name
  set_type :merchant_revenue
end