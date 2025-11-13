class StatusController < ApplicationController
  skip_before_action :authenticate
  def index
    render json: { status: 'ok' }, status: 200
  end
end
