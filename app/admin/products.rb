# frozen_string_literal: true

ActiveAdmin.register Product do
  permit_params :title, :description, :price, :contact_info, :size, :category

  filter :title
  filter :contact_info
  filter :scraped_at

  form do |f|
    f.inputs "Product Details" do
      f.input :title
      f.input :description
      f.input :price
      f.input :contact_info
      f.input :size
      f.input :category
    end
    f.actions
  end
end
