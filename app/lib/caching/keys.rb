module Caching
    module Keys
        def scraped_data_key(url:)
          "#{Rails.env}_scraped_data_#{Digest::MD5.hexdigest(url)}"
        end
    end
end