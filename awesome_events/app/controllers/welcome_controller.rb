class WelcomeController < ApplicationController
  skip_before_action :authenticate
  def index
    @events = Event.available.order(:start_at)
  end
end
