class MerchantNameRevenueSerializer
  include JSONAPI::Serializer
  attributes :name, :revenue
  set_type :merchant_name_revenue
end