class StatusPing < ApplicationRecord
  belongs_to :website

  after_update_commit -> { broadcast_replace_to :status_pings }
end
