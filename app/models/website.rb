require 'uri'

class Website < ApplicationRecord
  belongs_to :user
  validates :body, presence: true, format: URI::regexp(%w[http https])
end
