class TasksController < ApplicationController
  include Api

  before_action :find_record, only: [:show, :update, :destroy, :complete]

  def index_scope
    @collection = Task.where(board_id: params[:board_id])

    extra_scope = params['type'] && params['type'].to_sym
    if extra_scope && accessible_scopes.include?(extra_scope)
      @collection = @collection.send(extra_scope)
    end

    @collection
  end

  def complete
    @resource.update(completed_at: Time.zone.now)
    render json: @resource
  end

  private
    def accessible_scopes
      [:completed, :incompleted]
    end

    def params_for_create
      resource_params.merge(board_id: params[:board_id])
    end

    def resource_params
      params.require(:task).permit(:title, :description)
    end
end
