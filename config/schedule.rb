# frozen_string_literal: true

every 1.day, at: Time.zone.parse('7:00 am').utc.strftime('%H:%M') do
  rake 'scrapers:product_scraper_service', environment: Rails.env
end
