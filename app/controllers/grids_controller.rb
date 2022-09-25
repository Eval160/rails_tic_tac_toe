class GridsController < ApplicationController
  before_action :set_grid, only: [:show]

  def new
    @grid = Grid.new
  end

  def create
    @grid = Grid.new(grid_params)
    @grid.opponent = ia if params[:play_with_ia] == "true"

    @grid.user = current_user
    if @grid.save
      redirect_to grid_path(@grid)
    else
      render :new
    end
  end

  def show
  end
  
  private

  def grid_params
    params.require(:grid).permit(:opponent_id)
  end

  def set_grid
    @grid = Grid.find(params[:id])
  end

end
