require 'rails_helper'

RSpec.describe 'Api::V1::Github::Repositories', type: :request do
  describe 'GET api/v1/github/Repositories#index' do

    context 'when the request is authorized' do
      it 'returns status 200' do
        VCR.use_cassette('requests/github/repositories-200') do
          user = FactoryBot.create(:user)

          allow(
            UserAuthorizationService
          ).to receive(:call).and_return(user)

          get '/api/v1/github/repositories'

          expect(response).to have_http_status(200)
        end
      end

      it 'returns a json with the repositories' do
        VCR.use_cassette('requests/github/repositories-200') do
          user = FactoryBot.create(:user)

          allow(
            UserAuthorizationService
          ).to receive(:call).and_return(user)

          get '/api/v1/github/repositories'

          resp_body = JSON.parse(response.body)
          expect(resp_body).to match("repositories" => kind_of(Array))
        end
      end

      context 'when a parameter is passed' do
        it 'returns a json with the filtered repositories' do
          VCR.use_cassette('requests/github/repositories_search-200') do
            user = FactoryBot.create(:user)

            allow(
              UserAuthorizationService
            ).to receive(:call).and_return(user)

            get '/api/v1/github/repositories', params: { username: "defunkt" }

            resp_body = JSON.parse(response.body)

            expect(
              resp_body['repositories'].map { |repo| repo["author"] }
            ).to all eq('defunkt')
          end
        end
      end
    end

    context 'when the request is not authorized' do
      it 'returns status 401' do
        get '/api/v1/github/repositories'
        expect(response).to have_http_status(401)
      end
    end
  end
end