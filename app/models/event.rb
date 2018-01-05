class Event < ApplicationRecord
  validates :app, :resource, :action, :payload, presence: true
end
