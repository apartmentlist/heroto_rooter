class Event < ApplicationRecord
  validates :app, :name, :payload, presence: true

  HEROKU_PARAMS = %w[
    actor
    created_at
    data
    event
    id
    previous_data
    published_at
    resource
    sequence
    updated_at
    version
    webhook_metadata
  ]
end
