class CurrencySerializer < ActiveModel::Serializer
  attributes :iso, :name, :rate, :created_at
end
