class DashboardController < ApplicationController
  def index
    stat = {
      total_boards: Board.count,
      total_tasks: Task.count,
      incomplete_tasks: Task.incompleted.count
    }

    render json: stat
  end
end
