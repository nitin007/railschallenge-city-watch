class EmergenciesController < ApplicationController
  before_filter :render_not_found, only: [:new, :edit, :destroy]
  before_filter :build_emergency, only: [:create]
  before_filter :fetch_emergency, only: [:show, :update]

  def index
    emergencies = Emergency.all
    render json: { emergencies: emergencies, full_responses: [Emergency.with_full_response.size, Emergency.count] }
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
    render json: { emergency: @emergency } if @emergency.update(patch_params)
  end

  def create
    if @emergency.save
      render json: { emergency: { responders: @emergency.responders, full_response: Emergency.with_full_response }.merge(@emergency.as_json) }, status: 201
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

    def create_params
      params.require(:emergency).permit(:code, :fire_severity, :police_severity, :medical_severity)
    end

    def patch_params
      params.require(:emergency).permit(:fire_severity, :police_severity, :medical_severity, :resolved_at)
    end

    def build_emergency
      @emergency = Emergency.new(create_params)
    end

    def fetch_emergency
      @emergency = Emergency.find_by(code: params[:id])
    end
end
