require 'rails_helper'

RSpec.describe Github::ReposSearchService, type: :service do
  describe '#call' do
    it 'executes repositories search' do
      VCR.use_cassette('services/builder/query-builder') do
        params = { username: 'rubygems', per_page: 1 }

        repositories = described_class.call(params)

        expect(repositories).to eq(
          {
            :repositories=> [{
              :name=>"bundler",
              :description=>"Manage your Ruby application's gem dependencies",
              :stars=>4810,
              :forks=>2131,
              :author=>"rubygems"
            }]
          }
        )
      end
    end
  end
end
