class EmergenciesController < ApplicationController
  before_filter :render_not_found, except: [:create, :index]
  before_filter :build_emergency, only: [:create]

  def index
    emergencies = Emergency.all
    render json: { emergencies: emergencies }
  end

  def new
  end

  def update
    
  end

  def create
    if @emergency.save
      render json: { emergency: @emergency }, status: 201
    else
      render json: { message: @emergency.errors.to_hash }, status: 422
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

    def emergency_params
      params.require(:emergency).permit(:code, :fire_severity, :police_severity, :medical_severity)
    end

    def build_emergency
      @emergency = Emergency.new(emergency_params)
    end
end
