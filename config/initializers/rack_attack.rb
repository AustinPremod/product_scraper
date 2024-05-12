
Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

# Allow all requests from localhost
Rack::Attack.safelist('allow from localhost') do |req|
  '127.0.0.1' == req.ip || '::1' == req.ip
end

# Throttle requests to the 'scraped_data' endpoint by IP address
Rack::Attack.throttle('requests to scraped_data', limit: 5, period: 1.minute) do |req|
  req.path == '/api/v1/products/scraped_data' && req.post?
end

Rack::Attack.throttled_response = lambda do |env|
  retry_after = (env['rack.attack.match_data'] || {})[:period]
  [
    429,
    { 'Content-Type' => 'application/json', 'Retry-After' => retry_after.to_s },
    [{ error: 'Rate limit exceeded. Please try again later.' }.to_json]
  ]
end
