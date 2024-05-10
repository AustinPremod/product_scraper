# frozen_string_literal: true

class Product < ApplicationRecord
  def self.scrape_product_details
    ProductScraperService.scrape_product_details
  end
  def self.ransackable_attributes(auth_object = nil)
    %w[author category contact_info created_at description id price scraped_at title updated_at]
  end
end
