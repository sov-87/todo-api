class BoardsController < ApplicationController
  include Api

  private
    def resource_params
      params.require(:board).permit(:title, :description)
    end
end
