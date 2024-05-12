# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApplicationController
      include Caching::Keys
      skip_before_action :verify_authenticity_token, only: [:scraped_data]
      def scraped_data
        url = JSON.parse(request.body.read)['url']
        cache_key = scraped_data_key(url: url)
        cached_response = Rails.cache.read(cache_key)
        if cached_response.present?
          render json: { product: cached_response }
        else
          product = Product.scrape_product_details(url)
          if product.present? && product.is_a?(Product)
            serialized_product = ProductSerializer.new(product).as_json
            Rails.cache.write(cache_key, serialized_product, expires_in: 10.minutes)
            
            render json: { product: serialized_product }
          else
            render json: { error: 'Failed to save product details.' }, status: :unprocessable_entity
          end
        end
      end
    end
  end
end
