require 'rails_helper'

RSpec.describe Api::V1::TenantsController, type: :controller do
  describe "GET #index" do
    context 'with authentication' do
      let!(:tenants) { create_list(:tenant, 3) }

      it "returns a successful response" do
        get :index
        expect(response).to have_http_status(:ok)
      end

      it "returns a list of tenants" do
        get :index
        expect(json_response['tenants'].size).to eq(3)
      end

      #TODO check that returned items are correct
    end
  end

  describe "GET #show" do
    let(:tenant) { create(:tenant) }

    it "returns a successful response" do
      get :show, params: { id: tenant.id }
      expect(response).to have_http_status(:ok)
    end

    it "returns the specified tenant" do
      get :show, params: { id: tenant.id }
      expect(json_response["id"]).to eq(tenant.id)
    end
  end

  describe "POST #create" do
    let(:tenant_params) { attributes_for(:tenant) }

    it "creates a new tenant" do
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