class RespondersController < ApplicationController
  before_filter :render_not_found, except: [:create, :index]
  before_filter :build_emergency, only: [:create]

  def index
    responders = Responder.all
    render json: { responders: responders }
  end

  def new
  end

  def update

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
end
