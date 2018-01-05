class SlackNotifier
  attr_reader :event

  def initialize(event)
    @event = event
    @slack = Slack::Web::Client.new
  end

  def notify!
    slack.chat_postMessage(
      channel: '#hackathon',
      icon_emoji: ':mega:',
      text: event.name,
      username: event.app
    )
  end

  private

  attr_reader :slack
end
