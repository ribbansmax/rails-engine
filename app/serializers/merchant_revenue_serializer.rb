class MerchantRevenueSerializer
  include JSONAPI::Serializer
  attributes :revenue
  set_type :merchant__revenue
end