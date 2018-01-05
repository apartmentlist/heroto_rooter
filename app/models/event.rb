class Event < ApplicationRecord
  validates :app, :resource, :action, :payload, presence: true

  NOTIFICATION_MAP = {
    %w[release create] => Notification::Deploy
  }

  def notification
    notification_class&.new(self)
  end

  def notification_class
    NOTIFICATION_MAP[[resource, action]]
  end
end
