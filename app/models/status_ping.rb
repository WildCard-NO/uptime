class StatusPing < ApplicationRecord
  belongs_to :website

  after_create_commit :send_status_change_email

  after_create_commit -> { broadcast_replace_to "status_pings_#{website.id}", target: "status_pings", partial: "status_pings/status_pings", locals: { status_pings: self.website.status_pings.order(created_at: :desc).limit(25).reverse  } }

  private

  def send_status_change_email
    last_status_ping = self.website.status_pings.where.not(id: self.id).order(created_at: :desc).first
    if last_status_ping && last_status_ping.status_number != self.status_number
      new_status = status_number == 1 ? "online" : "offline"
      begin
        TestMailer.status_change(website, new_status).deliver_now
      end
    end
  end
end
