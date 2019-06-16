require 'rails_helper'

RSpec.describe AuthorizeApiRequest do
  # Create test user
  let(:user) { create(:user, :as_candidate) }
  # Mock `Authorization` header
  let(:header) { valid_headers(user) }
  # Invalid request subject
  subject(:invalid_request_obj) { described_class.new({}) }
  # Valid request subject
  subject(:request_obj) { described_class.new(header) }

  # Test Suite for AuthorizeApiRequest#call
  # This is our entry point into the service class
  describe '#call' do
    # returns user object when request is valid
    context 'when valid request' do
      it 'returns user object' do
        result = request_obj.call
        expect(result.try(:id)).to eq(user.id)
      end
    end

    # returns error message when invalid request
    context 'when invalid request' do
      context 'when missing token' do
        it 'raises a MissingToken error' do
          expect { invalid_request_obj.call }
              .to raise_error(ExceptionHandler::MissingToken, 'Missing token')
        end
      end

      context 'when invalid token' do
        subject(:invalid_request_obj) do
          # custom helper method `token_generator`
          described_class.new( invalid_headers_token )
        end

        it 'raises an InvalidToken error' do
          expect { invalid_request_obj.call }
              .to raise_error(JWT::DecodeError, 'Invalid segment encoding')
        end
      end

      context 'when token is expired' do
        let!(:header) { valid_headers(user) }
        subject!(:request_obj) { described_class.new(header) }

        it 'raises ExceptionHandler::ExpiredSignature error' do
          travel_to(Time.now + 2.days) do
            expect { request_obj.call }
                .to raise_error(JWT::ExpiredSignature, 'Signature has expired')
          end
        end
      end

      context 'fake token' do
        let(:header) { { 'Authorization' => 'foobar' } }
        subject(:invalid_request_obj) { described_class.new(header) }

        it 'handles JWT::DecodeError' do
          expect { invalid_request_obj.call }
              .to raise_error( JWT::DecodeError, 'Not enough or too many segments')
        end
      end
    end
  end
end