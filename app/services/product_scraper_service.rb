# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
class ProductScraperService
  def self.scrape_product_details(url)    
    html = URI.open(url)
    doc = Nokogiri::HTML(html)

    title = extract_title(doc)
    description = extract_description(doc)
    price = extract_price(doc)
    category = extract_category(doc)
    contact_info = extract_contact_info(doc)
    size = extract_size(doc)
    Product.transaction do
      product = Product.find_or_initialize_by(
        title: title,
        description: description,
        price: price,
        category: category,
        contact_info: contact_info,
        size: size,
        scraped_at: Time.zone.now
      )
      product.save!
      product
    end
  rescue StandardError => e
    Rails.logger.error("Error scraping product details: #{e.message}")
  end

  def self.extract_title(doc)
    title = doc.title.strip if doc.title
    title ||= doc.at('meta[property="og:title"]')&.[]('content')&.strip
    title ||= doc.at('meta[name="twitter:title"]')&.[]('content')&.strip
    title ||= doc.at('h1')&.text&.strip
    title
  end

  def self.extract_description(doc)
    description = doc.at('meta[name="description"]')&.[]('content')&.strip
    description ||= doc.at('meta[property="og:description"]')&.[]('content')&.strip
    description ||= doc.at('meta[name="twitter:description"]')&.[]('content')&.strip
    description
  end

  def self.extract_price(doc)
    price = doc.at('.price')&.text&.strip
    price ||= doc.at('.product-price')&.text&.strip
    price ||= doc.at('.price-tag')&.text&.strip
    price
  end

  def self.extract_category(doc)
    category = doc.at('.category')&.text&.strip
    category ||= doc.at('.product-category')&.text&.strip
    category
  end

  def self.extract_contact_info(doc)
    contact_info = doc.at('.contact-info')&.text&.strip
    contact_info ||= doc.at('.product-contact')&.text&.strip
    contact_info
  end

  def self.extract_size(doc)
    size = doc.at('.size')&.text&.strip
    size ||= doc.at('.product-size')&.text&.strip
    size
  end
end
