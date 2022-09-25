class CellsController < ApplicationController
  before_action :set_cell, only: [:update]
  def update
    return if @cell.user_id?
    grid = @cell.grid
    @cell.user = current_user
    if @cell.save
      GridChannel.broadcast_to(
       grid,
        {
          user_id: current_user.id,
          grid_html: render_to_string(partial: "grids/grid", locals: {grid: grid, user: grid.user_who_plays})
        }
      )
      if grid.in_progress? && grid.user_who_plays == ia
        grid.auto_play
      end

      redirect_to grid_path(grid)
    else
      redirect_to grid_path(grid)
    end
  end

  private

  def set_cell
    @cell = Cell.find(params[:id])
  end
  
  
end
