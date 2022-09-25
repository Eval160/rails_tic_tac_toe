class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if current_user
      @in_progress_grids = current_user.grids.in_progress
      @passed_grids = current_user.grids.where(state: !"in_progress")
    end
  end
end
