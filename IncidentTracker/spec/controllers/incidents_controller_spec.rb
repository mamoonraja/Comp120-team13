require 'rails_helper'
require 'spec_helper'

describe IncidentsController do
  describe "POST #create" do
    context 'valid attributes' do
      it 'creates the incident' do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in FactoryGirl.create(:user)
        post :create, incident: FactoryGirl.attributes_for(:incident)
        expect(Incident.count).to eq(1)
      end
      it 'redirects to the incident view page' do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in FactoryGirl.create(:user)
        post :create, incident: FactoryGirl.attributes_for(:incident)
        expect(response).to redirect_to Incident.first
      end
    end

    context 'invalid attributes' do #if nothing added
      it 'incident not created' do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in FactoryGirl.create(:user)
        expect {
          post :create, incident: FactoryGirl.attributes_for(:incident, severity: nil)
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
