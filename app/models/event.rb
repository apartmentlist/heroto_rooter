class Event < ApplicationRecord
  validates :app, :resource, :action, :payload, presence: true

  module Status
    PENDING        = 'pending'
    SUCCESSFUL     = 'successful'
    FAILED         = 'failed'
    DEBOUNCED      = 'debounced'
    NOT_CONFIGURED = 'not_configured'
  end

  NOTIFICATION_MAP = {
    %w[release create] => Notification::Deploy
  }

  def debounced!
    update_attributes!(status: Status::DEBOUNCED)
  end

  def duplicate?
    recent = previous_success
    recent.successful? && recent.created_at > created_at - 1.minute
  end

  def failed!
    update_attributes!(status: Status::FAILED)
  end

  def previous_success
    Event
      .where(app: app, resource: resource, status: Status::SUCCESSFUL)
      .where.not(id: id)
      .last
  end

  def notification
    notification_class&.new(self)
  end

  def notification_class
    NOTIFICATION_MAP[[resource, action]]
  end

  def not_configured!
    update_attributes!(status: Status::NOT_CONFIGURED)
  end

  def successful!
    update_attributes!(status: Status::SUCCESSFUL)
  end

  def successful?
    status == Status::SUCCESSFUL
  end
end
