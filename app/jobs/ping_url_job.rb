class PingUrlJob < ApplicationJob
  queue_as :default

  def perform(website_id)
    website = Website.find_by(id: website_id)
    return unless website # Stop if the website is deleted

    # Ping the website (fetch latest URL from the database)
    begin
      response = HTTParty.get(website.body)
      website_status = response.success? ? 'online' : 'offline'
    rescue StandardError
      website_status = 'offline' # Mark as offline if the ping fails
    end

    # Update the website status
    website.update(status: website_status)

    # Create a StatusPing entry for tracking the status number
    status_number = website_status == 'online' ? 1 : 0
    StatusPing.create(website: website, status_number: status_number)

    # Re-schedule the job
    self.class.set(wait: website.time.seconds).perform_later(website.id) if website.time.present?
  end
end
