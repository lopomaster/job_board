require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController, type: :request do
  # initialize test data

  let(:user_candidate_params) {
      { user: { email: "usermail@usermail.com", password: "mypassword", password_confirmation: "mypassword", username: "lopomaster", first_name: "fn", last_name: "ln", profile_type: "Candidate", profile_attributes: { profession: "RoR Programmer", notes: "notes"} }
    }.to_json
  }

  let(:user_company_params) {
    { user: { email: "usermail2@usermail2.com", password: "mypassword", password_confirmation: "mypassword", username: "lopomaster_company", first_name: "fn", last_name: "ln", profile_type: "Company", profile_attributes: { name: "RoR Programmer", description: "notes"} }
    }.to_json
  }

  let(:invalid_user_params) { {"user": {"username": 'username', "password": 'fake_pass' }}.to_json }

  describe 'GET /api/v1/users/sign_up/' do

    context 'Create an user as Candidate -> returns status code 200' do
      it 'returns 200' do
        expect{ post "/api/v1/users", params: user_candidate_params, headers: { 'Content-Type' => 'application/json' } }.to change(User, :count).by(1)
        expect(response).to have_http_status(200)
        expect(User.count).to eq(1)
        expect(User.first.profile_type).to eq('Candidate')

      end
    end

    context 'Create an user as Company -> returns status code 200' do
      it 'returns 200' do
        expect{ post "/api/v1/users", params: user_company_params, headers: { 'Content-Type' => 'application/json' } }.to change(User, :count).by(1)
        expect(response).to have_http_status(200)
        expect(User.count).to eq(1)
        expect(User.first.profile_type).to eq('Company')
      end
    end

    context 'when params is invalid' do
      it 'returns status code 200 and token nil' do
        expect{ post "/api/v1/users", params: invalid_user_params, headers: { 'Content-Type' => 'application/json' } }.to change(User, :count).by(0)
        expect(response).to have_http_status(400)
      end
    end
  end
end