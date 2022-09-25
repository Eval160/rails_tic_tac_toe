class GridChannel < ApplicationCable::Channel
  def subscribed
    grid = Grid.find(params[:id])
    stream_for grid
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
