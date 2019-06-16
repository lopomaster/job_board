require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :request do
  # initialize test data
  let(:user) { create(:user) }

  let(:user_params) { {"user": {"username": user.username, "password": user.password }}.to_json }
  let(:invalid_user_params) { {"user": {"username": user.username, "password": 'fake_pass' }}.to_json }


  describe 'GET /api/users/sign_in/' do

    context 'returns status code 200' do
      before { post "/api/v1/users/sign_in/", params: user_params, headers:  valid_headers(user)  }

      it 'returns the token' do
        expect(json['response']).to eq('Authentication successful')
        expect(response).to have_http_status(200)
        expect(json['response']).to be_a(String)
      end
    end

    context 'when the password is invalid' do
      before { post "/api/v1/users/sign_in/", params: invalid_user_params, headers: headers  }

      it 'returns status code 200 and token nil' do
        expect(json['response']).to be_a(String)
        expect(json['response']).to eq('Authentication failed')
        expect(json['token']).to eq(nil)
        expect(response).to have_http_status(200)
      end
    end
  end
end