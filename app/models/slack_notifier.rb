class SlackNotifier
  attr_reader :notification, :rooter

  def initialize(notification)
    @notification = notification
    @slack = Slack::Web::Client.new
    @rooter = Rooter.find_by(app: notification.app)
  end

  def notify!
    event.not_configured! and return unless rooter
    event.debounced! and return if event.duplicate?
    post!
    event.successful!
  rescue
    event.failed!
    raise
  end

  private

  def event
    notification.event
  end

  def post!
    slack.chat_postMessage(
      channel: "##{rooter.channel}",
      icon_emoji: ":#{rooter.emoji}:",
      text: notification.body,
      username: notification.app
    )
  end

  attr_reader :slack
end
