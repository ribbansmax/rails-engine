class MerchantRevenueSerializer
  include JSONAPI::Serializer
  attributes :revenue
  set_type :merchant_revenue
end