class SlackNotifier
  attr_reader :event

  def initialize(event)
    @event = event
    @slack = Slack::Web::Client.new
  end

  def notify!
    rooter = Rooter.find_by(app: event.app)
    return unless rooter

    slack.chat_postMessage(
      channel: "##{rooter.channel}",
      icon_emoji: ":#{rooter.emoji}:",
      text: event.name,
      username: event.app
    )
  end

  private

  attr_reader :slack
end
