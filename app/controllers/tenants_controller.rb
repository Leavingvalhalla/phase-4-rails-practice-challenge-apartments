class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    def index
        render json: Tenant.all, status: :ok
    end

    def show
        render json: Tenant.find(params[:id]), status: :ok
    end

    def create
         tenant = Tenant.new(tenant_params)
         if tenant.valid?
            render json: Tenant.create(tenant_params)
         else
            render json: {error: tenant.errors}, status: :unprocessable_entity
         end
    end

    def update
        tenant = Tenant.find(params[:id])
        if params[:age].to_i < 18
            render json: {error: 'Tenant must be at least 18!'}, status: :unprocessable_entity
        else
        tenant.update(name: params[:name], age: params[:age])
        render json: tenant, status: :ok
        end
    end

    def destroy
        tenant = Tenant.find(params[:id])
        render json: tenant.destroy, status: :ok
    end

    private

    def tenant_params
        params.permit(:name, :age)
    end

    def not_found
        render json: {error: 'not found'}, status: :not_found
    end
end
