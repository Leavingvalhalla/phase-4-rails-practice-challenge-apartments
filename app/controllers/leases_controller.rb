class LeasesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    
    def create
         render json: Lease.create(lease_params), status: :created
    end

    def destroy
        lease = Lease.find(params[:id])
        render json: lease.destroy, status: :ok
    end
    
    private

    def lease_params
        params.permit(:rent)
    end

    def not_found
        render json: {error: 'not found'}, status: :not_found
    end

end

end
