class ActorFilter
  attr_reader :event

  ANNOYING_ACTORS = %w[
    heroku-postgresql
    heroku-redis
    hirefire
  ]

  def initialize(event)
    @event = event
  end

  def filter?
    ANNOYING_ACTORS.any? do |actor|
      event.actor.include?(actor)
    end
  end
end
