# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
class ProductScraperService
  def self.scrape_product_details
    url =  Rails.configuration.ss_settings['scrape_product']['url']
    html = URI.open(url)
    doc = Nokogiri::HTML(html)
    products = []
    items = doc.css('.item')
    ActiveRecord::Base.transaction do
      items.each do |item|
        title = item.at_css('.item-heading').text.strip
        description = item.at_css('.item-body').text.strip
        author = item.at_css('.item-byline').text.strip
        next unless author.present? && description.present? && title.present?

        products << Product.new(title: title, description: description, author: author, scraped_at: Time.zone.now)
      end
      Product.import(products, on_duplicate_key_update: { conflict_target: [:title] })
    end
  rescue StandardError => e
    Rails.logger.info("Error scraping product details: #{e.message}")
  end
end
