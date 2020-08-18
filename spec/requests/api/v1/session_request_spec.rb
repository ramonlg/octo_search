require 'rails_helper'

RSpec.describe 'Api::V1::Session', type: :request do
  describe 'POST api/v1/Session#create' do
    context 'when the data informed is valid' do
      it 'authenticates the user' do
        user = FactoryBot.create(:user)

        post '/api/v1/session', params: { username: user.username, password: user.password }

        body = JSON.parse(response.body)

        expect(body).to have_key('auth_token')
        expect(body['auth_token']).to be_present
      end

      it 'returns status 200' do
        user = FactoryBot.create(:user)

        post '/api/v1/session', params: { username: user.username, password: user.password }

        expect(response).to have_http_status(200)
      end
    end

    context 'when the data informed is invalid' do
      it 'returns status 401' do
        post '/api/v1/session'

        post '/api/v1/session', params: { username: 'some_name', password: 'xxx' }

        expect(response).to have_http_status(401)
      end
    end
  end
end