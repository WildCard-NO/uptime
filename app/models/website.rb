require 'uri'

class Website < ApplicationRecord
  belongs_to :user
  has_many :status_pings, dependent: :destroy
  validates :body, presence: true, format: URI::regexp(%w[http https])
  after_update_commit -> { broadcast_replace_to :websites }

  enum status: { offline: 0, online: 1 }
  before_save :strip_trailing_spaces
  def status_with_number
    "#{status} (#{status_number})"
  end

  def status_number
    status == "online" ? 1 : 0
  end

  def status_array
    
  end

  private

  def strip_trailing_spaces
    self.body = self.body.strip
    self.title = self.title.strip
  end
end
