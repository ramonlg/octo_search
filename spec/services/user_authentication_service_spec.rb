require 'rails_helper'

RSpec.describe UserAuthenticationService, type: :service do
  describe '#call' do
    context 'when the user can be authenticated' do
      it 'authenticates user' do
        user = FactoryBot.create(:user)
        params = { username: user.username, password: user.password }

        user_auth = described_class.call(params)

        expect(user_auth[:status]).to eq(:ok)
        expect(user_auth[:content].keys).to include(:auth_token)
        expect(user_auth[:content][:auth_token]).to be_present
      end
    end

    context 'when the user cannot be authenticated' do
      it 'does not authenticate user' do
        user = FactoryBot.create(:user)
        params = { username: user.username, password: 'xxxx' }

        user_auth = described_class.call(params)

        expect(user_auth[:status]).to eq(:unauthorized)
        expect(user_auth[:content].keys).not_to include(:auth_token)
        expect(user_auth[:content][:auth_token]).to be_blank
      end
    end
  end
end
