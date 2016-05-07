class EmergenciesController < ApplicationController
  before_filter :render_not_found, except: [:create]
  before_filter :build_emergency, only: [:create]

  def new
  end

  def create
    if @emergency.save
      render json: @emergency
    else

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

    def build_emergency
      @emergency = Emergency.new(params[:emergency])
    end
end
