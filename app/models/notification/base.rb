module Notification
  class Base
    attr_reader :event

    def initialize(event)
      @event = event
    end

    def actor
      event.actor.capitalize
    end

    def app
      event.app
    end

    def body
      raise NotImplementedError,
        "##{__method__} must be implemented by a subclass"
    end

    def data
      event.payload['data']
    end
  end
end
