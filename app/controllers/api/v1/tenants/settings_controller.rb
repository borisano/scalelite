class Api::V1::Tenants::SettingsController < ApplicationController
  before_action :set_tenant
  # entire controller
  skip_before_action :verify_authenticity_token
  def index
    render json: { settings: @tenant.custom_settings }
  end

  def create
    @tenant.update(settings_params)
    render json: { message: "Settings set successfully for Tenant #{@tenant}" }
  end

  def update
    @tenant.settings.update(settings_params)
    render json: { message: "Settings updated successfully for Tenant #{@tenant}" }
  end

  def destroy
    setting = @tenant.settings.find_by(name: params[:name])
    if setting.present?
      setting.destroy
      render json: { message: "Settings was successfully removed from Tenant #{@tenant}" }
    else
      render json: { message: "Could not find the specified setting for Tenant #{@tenant}" }, status: :not_found
    end
  end

  private

  def set_tenant
    @tenant = Tenant.find(params[:tenant_id])
  end

  def settings_params
    params.require(:settings).permit(:name, :value)
  end
end