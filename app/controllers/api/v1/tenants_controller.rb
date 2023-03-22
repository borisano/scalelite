class Api::V1::TenantsController < ApplicationController
  skip_forgery_protection

  def index
    @tenants = Tenant.all
    render json: { tenants: @tenants }
  end

  def show
    @tenant = Tenant.find(params[:id])
    render json: @tenant
  end

  def create
    @tenant = Tenant.new(tenant_params)
    if @tenant.save
      render json: @tenant, status: :created
    else
      render json: @tenant.errors, status: :unprocessable_entity
    end
  end

  def update
    @tenant = Tenant.find(params[:id])
    if @tenant.update(tenant_params)
      render json: @tenant, status: :ok
    else
      render json: @tenant.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @tenant = Tenant.find(params[:id])
    @tenant.destroy
    head :no_content
  end

  private

  def tenant_params
    params.require(:tenant).permit(:name, :secrets)
  end
end