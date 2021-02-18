class ItemRevenueSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :unit_price, :merchant_id, :revenue
  set_type :item_revenue
end