require 'rails_helper'
require 'spec_helper'

describe Users::SessionsController do
  describe "POST #create" do
    it 'authenticates a user' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in FactoryGirl.create(:user)
      expect(response.status).to eq(200)
    end
  end
end
