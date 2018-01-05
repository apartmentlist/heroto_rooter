class SlackNotifier
  attr_reader :notification

  def initialize(notification)
    @notification = notification
    @slack = Slack::Web::Client.new
  end

  def notify!
    rooter = Rooter.find_by(app: notification.app)
    return unless rooter

    slack.chat_postMessage(
      channel: "##{rooter.channel}",
      icon_emoji: ":#{rooter.emoji}:",
      text: notification.body,
      username: notification.app
    )
  end

  private

  attr_reader :slack
end
