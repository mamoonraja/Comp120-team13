require 'rails_helper'
require 'spec_helper'

describe Users::RegistrationsController do
  describe "POST #create" do
    context 'valid attributes' do
      it 'creates a user' do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(User.count).to eq(1)
      end
      it 'redirects to the root page' do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response).to redirect_to root_path
      end
    end
  end
end
