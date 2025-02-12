require 'uri'

class Website < ApplicationRecord
  belongs_to :user
  validates :body, presence: true, format: URI::regexp(%w[http https])
  after_update_commit -> { broadcast_replace_to :websites }
end
