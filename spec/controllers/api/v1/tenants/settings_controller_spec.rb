require 'rails_helper'

RSpec.describe Api::V1::Tenants::SettingsController, type: :controller do
  describe "GET #index" do
    def get_index(tenant_id, params = {})
      get :index, params: params.merge({tenant_id: tenant_id})
    end

    context 'with authentication' do
      let(:tenant) { create :tenant }
      let!(:settings) { create_list :tenant_settings, rand(2..10), tenant: tenant }

      it "returns a successful response" do
        get_index(tenant.id)
        expect(response).to have_http_status(:ok)
      end

      it "returns a list of settings of correct size" do
        get_index(tenant.id)

        expect(json_response['settings']).to be_present
        expect(json_response['settings'].size).to eq(settings.size)
      end

      # TODO validate specific items
    end

    context 'without proper authentication' do
      context 'with missing hash' do

      end

      context 'with incorrect hash' do

      end
    end
  end

  describe "POST #create" do
    let(:tenant) { create :tenant }
    let(:settings) { build_list(:tenant_settings, rand(2..10), tenant: tenant) }
    let(:params) {
      settings: {
        name: FactoryBot::Animal.
      }
    }

    it "creates new settings" do
      expect {
        post :create, params: { tenant: tenant_params }
      }.to change(Tenant, :count).by(1)
    end

    it "returns a successful response" do
      post :create, params: { tenant: tenant_params }
      expect(response).to have_http_status(:created)
    end
  end

  describe "PUT #update" do
    let(:tenant) { create(:tenant) }
    let(:new_tenant_params) { attributes_for(:tenant) }

    it "updates the specified tenant" do
      put :update, params: { id: tenant.id, tenant: new_tenant_params }
      expect(tenant.reload.name).to eq(new_tenant_params[:name])
    end

    it "returns a successful response" do
      put :update, params: { id: tenant.id, tenant: new_tenant_params }
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE #destroy" do
    let!(:tenant) { create(:tenant) }

    it "deletes the specified tenant" do
      expect {
        delete :destroy, params: { id: tenant.id }
      }.to change(Tenant, :count).by(-1)
    end

    it "returns a successful response" do
      delete :destroy, params: { id: tenant.id }
      expect(response).to have_http_status(:no_content)
    end
  end

  def json_response
    JSON.parse(response.body)
  end
end