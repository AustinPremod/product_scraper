# frozen_string_literal: true

ActiveAdmin.register Product do
  permit_params :title, :description, :price, :contact_info, :author, :category, :scraped_at

  filter :title
  filter :contact_info
  filter :author
  filter :scraped_at
end
