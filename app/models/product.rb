# frozen_string_literal: true

class Product < ApplicationRecord
  def self.scrape_product_details(url)
    ProductScraperService.scrape_product_details(url)
  end
  def self.ransackable_attributes(auth_object = nil)
    %w[size category contact_info created_at description id price title updated_at]
  end
end
