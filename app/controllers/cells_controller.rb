class CellsController < ApplicationController
  before_action :set_cell, only: [:update]
  def update
    return if @cell.user_id?

    @cell.user = current_user
    if @cell.save
      GridChannel.broadcast_to(
        @cell.grid,
        {
          user_id: current_user.id,
          grid_html: render_to_string(partial: "grids/grid", locals: {grid: @cell.grid, user: @cell.grid.user_who_plays})
        }
      )
      redirect_to grid_path(@cell.grid)
    else
      redirect_to grid_path(@cell.grid)
    end
  end

  private

  def set_cell
    @cell = Cell.find(params[:id])
  end
  
  
end
