class PingUrlJob < ApplicationJob
  queue_as :default

  def perform(website_id)
    website = Website.find_by(id: website_id)
    return unless website # Stop if the website is deleted

    # Ping the website (fetch latest URL from the database)
    begin
      response = HTTParty.get(website.body)
      website.update(status: response.success? ? 'online' : 'offline')
    rescue StandardError
      website.update(status: 'offline') # Mark as offline if the ping fails
    end

    # Re-schedule the job
    self.class.set(wait: website.time.seconds).perform_later(website.id) if website.time.present?
  end
end
