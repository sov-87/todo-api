class Task < ActiveRecord::Base
  def board
    Board.find(self.board_id)
  end
end
