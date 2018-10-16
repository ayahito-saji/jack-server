class EventsController < ApplicationController
  def show
    @event = Event.find_by(event_id: params[:event_id])
  end
end
