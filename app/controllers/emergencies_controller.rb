class EmergenciesController < ApplicationController
  before_filter :render_not_found, except: [:create, :index, :show]
  before_filter :build_emergency, only: [:create]
  before_filter :fetch_emergency, only: [:show, :update]

  def index
    emergencies = Emergency.all
    render json: { emergencies: emergencies, full_responses: [Emergency.full_response, Emergency.count] }
  end

  def new
  end

  def show
    if @emergency
      render json: { emergency: @emergency }
    else
      render nothing: true, status: 404
    end
  end

  def update
    if @emergency.update(emergency_params)
      render status: 200
    end
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
      params.require(:emergency).permit(:code, :fire_severity, :police_severity, :medical_severity, :resolved_at)
    end

    def build_emergency
      @emergency = Emergency.new(emergency_params)
    end

    def fetch_emergency
      @emergency = Emergency.find_by(code: params[:id])
    end
end
