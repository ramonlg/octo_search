require 'rails_helper'

RSpec.describe UserAuthorizationService, type: :service do
  describe '#call' do
    context 'when the informed token is valid' do
      it 'authorizes and return the user' do
        user = FactoryBot.create(:user)
        token = user_token(user)

        headers = ActionDispatch::Http::Headers.from_hash({ "HTTP_USER_AGENT" => "curl/7.54.0" })
        headers["Authorization"] = user_token(user)

        authorized_user = described_class.call(headers)

        expect(authorized_user).to eq(user)
      end
    end

    context 'when the informed token is not valid' do
      it 'does not authorizes the user and return nil' do
        headers = ActionDispatch::Http::Headers.from_hash({ "HTTP_USER_AGENT" => "curl/7.54.0" })
        headers["Authorization"] = ''

        authorized_user = described_class.call(headers)

        expect(authorized_user).to  be_blank
      end
    end
  end

  def user_token(user)
    JsonWebToken.encode(user_id: user.id)
  end
end
