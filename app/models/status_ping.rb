class StatusPing < ApplicationRecord
  belongs_to :website

  after_create_commit -> { broadcast_replace_to "status_pings_#{website.id}", target: "status_pings", partial: "status_pings/status_pings", locals: { status_pings: self.website.status_pings.order(created_at: :desc).limit(25).reverse  } }
end
