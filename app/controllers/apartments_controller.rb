class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found
    def index
        render json: Apartment.all, status: :ok
    end

    def show
        render json: Apartment.find(params[:id]), status: :ok
    end

    def create
         render json: Apartment.create(apartment_params), status: :created
    end

    def update
        apartment = Apartment.find(params[:id])
        apartment.update(number: params[:number])
        render json: apartment, status: :ok
    end

    def destroy
        apartment = Apartment.find(params[:id])
        render json: apartment.destroy, status: :ok
    end

    private

    def apartment_params
        params.permit(:number)
    end
    def not_found
        render json: {error: 'not found'}, status: :not_found
    end
end
