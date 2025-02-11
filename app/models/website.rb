require 'uri'

class Website < ApplicationRecord
  belongs_to :user
  validates :body, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp, message: "must be a valid URL" }
end
