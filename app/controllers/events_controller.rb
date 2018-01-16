class EventsController < ApplicationController
  def create
    event = Event.new(event_params)

    if event.save
      SlackNotifier.new(event).notify!
      head :ok
    else
      Rails.logger.error(event.errors.full_messages)
      render json: event.errors, status: :unprocessable_entity
    end
  end

  private

  def event_params
    {
      app: payload.dig(*%w[data app name]) || payload.dig(*%w[data name]),
      resource: payload['resource'],
      action: payload['action'],
      payload: payload
    }
  end

  def payload
    @payload ||= JSON.parse(request.body.read)
  end
end
