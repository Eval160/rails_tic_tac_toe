class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if current_user
      @in_progress_grids = current_user.grids.in_progress.order(created_at: :desc)
      @passed_grids = current_user.grids.where.not(state: "in_progress").order(updated_at: :desc)
    end
  end
end
