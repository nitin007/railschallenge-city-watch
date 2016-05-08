class RespondersController < ApplicationController
  before_filter :render_not_found, only: [:new, :edit, :destroy]
  before_filter :build_emergency, only: [:create]
  before_filter :fetch_responder, only: [:show, :update]

  def index
    if asking_for_capacity?
      render json: { capacity: Responder.capacities_per_group }
    else
      responders = Responder.all
      render json: { responders: responders.as_json(only: [:emergency_code, :type, :name, :capacity, :on_duty]) }
    end
  end

  def new
  end

  def show
    if @responder
      render json: { responder: @responder.as_json(only: [:emergency_code, :type, :name, :capacity, :on_duty]) }
    else
      render nothing: true, status: :not_found
    end
  end

  def update
    render json: { responder: @responder } if @responder.update(responder_params)
  end

  def create
    if @responder.save
      render json: { responder: @responder.as_json(only: [:emergency_code, :type, :name, :capacity, :on_duty]) }, status: 201
    else
      render json: { message: @responder.errors.to_hash }, status: 422
    end
  end

  def edit
  end

  def update
    responder = Responder.find_by(name: params[:id])

    if responder.update(responder_params)
      render status: 200
    end
  end

  def destroy
  end

  private

    def render_not_found
      render json: {message: "page not found"}, status: 404
    end

    def responder_params
      params.require(:responder).permit(:type, :name, :capacity)
    end

    def build_emergency
      @responder = Responder.new(responder_params)
    end

    def fetch_responder
      @responder = Responder.find_by(name: params[:id])
    end

    def asking_for_capacity?
      params[:show].eql?('capacity')
    end
end
