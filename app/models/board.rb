class Board < ActiveRecord::Base
  def tasks
    Task.where(board_id: self.id)
  end
end
