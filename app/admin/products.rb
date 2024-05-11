# frozen_string_literal: true

ActiveAdmin.register Product do
  permit_params :title, :description, :price, :contact_info, :author, :category

  filter :title
  filter :contact_info
  filter :author
  filter :scraped_at

  form do |f|
    f.inputs "Product Details" do
      f.input :title
      f.input :description
      f.input :price
      f.input :contact_info
      f.input :author
      f.input :category
    end
    f.actions
  end
end
