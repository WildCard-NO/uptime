class PingUrlJob < ApplicationJob
  queue_as :default

  def perform(website_id)
    website = Website.find(website_id)
    url = website.body

    begin
      response = Net::HTTP.get_response(URI.parse(url))

      # You can log the response or handle success/failure here
      if response.is_a?(Net::HTTPSuccess)
        Rails.logger.info "Successfully pinged #{url}!"
      else
        Rails.logger.error "Failed to ping #{url}: #{response.code}"
      end
    rescue StandardError => e
      Rails.logger.error "Error pinging #{url}: #{e.message}"
    end
  end
end
