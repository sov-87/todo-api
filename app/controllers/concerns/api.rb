require 'active_support/concern'

module Api
  extend ActiveSupport::Concern

  included do
    before_action :get_model
    before_action :find_record, only: [:show, :update, :destroy]
  end

  def index
    @collection = index_scope.all
    render json: @collection
  end

  def show
    render json: @resource
  end

  def create
    @resource = @model_class.create(params_for_create)
    render json: @resource
  end

  def update
    @resource.update(resource_params)
    render json: @resource
  end

  def destroy
    @resource.destroy
    render json: @resource
  end

  protected
    def get_model
      model_name = controller_name.classify

      @model_class = model_name.constantize
    end

    def resource_params
      raise 'not implemented yet'
    end

    def params_for_create
      resource_params
    end

    def find_record
      @resource = @model_class.find(params[:id])
    end

    def index_scope
      @model_class.all
    end
end
