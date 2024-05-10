# frozen_string_literal: true

namespace :scrapers do
  desc 'scrapeing data from website'
  task product_scraper_service: :environment do
    Product.scrape_product_details
  end
end
