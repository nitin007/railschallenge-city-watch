class EmergenciesController < ApplicationController
  before_filter :render_not_found

  def new
  end

  def edit
  end

  def destroy
  end

  private

    def render_not_found
      render json: {message: "page not found"}, status: 404
    end
end
