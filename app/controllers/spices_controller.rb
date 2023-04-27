class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_error
    wrap_parameters format: []

    def index
        render json: Spice.all, status: :ok
    end

    def create
        render json: Spice.create(spice_params), status: :created
    end

    def update
        spice = find_spice.update(spice_params)
        render json: find_spice
    end

    def destroy
        find_spice.destroy
        head :no_content
    end

    private

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def render_not_found_error
        render json: { error: 'Spice not found'}, status: :not_found
    end

    def find_spice
        Spice.find(params[:id])
    end
end

