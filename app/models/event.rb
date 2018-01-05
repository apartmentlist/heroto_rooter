class Event < ApplicationRecord
  validates :app, :name, :payload, presence: true
end
