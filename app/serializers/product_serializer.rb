class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :category, :contact_info, :size, :scraped_at
end
