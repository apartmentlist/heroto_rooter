class SlackNotifier
  attr_reader :event

  def initialize(event)
    @event = event
  end

  def notify!
    return unless validate!
    post!
    event.successful!
  rescue
    event.failed!
    raise
  end

  private

  def post!
    slack.chat_postMessage(
      channel: "##{rooter.channel}",
      icon_emoji: ":#{rooter.emoji}:",
      text: event.message,
      username: event.app
    )
  end

  def rooter
    return @rooter if instance_variable_defined?('@rooter')
    @rooter = Rooter.find_by(app: event.app)
  end

  def slack
    @slack ||= Slack::Web::Client.new
  end

  def validate!
    event.filtered! and return false if ActorFilter.new(event).filter?
    event.not_implemented! and return false unless event.message
    event.not_configured! and return false unless rooter
    event.debounced! and return false if event.duplicate?
    true
  end
end
