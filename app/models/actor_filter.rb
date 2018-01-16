class ActorFilter
  attr_reader :event

  ANNOYING_ACTORS = %w[
    heroku-postgresql
    heroku-redis
  ]

  def initialize(event)
    @event = event
  end

  def filter?
    event.actor.in?(ANNOYING_ACTORS)
  end
end
