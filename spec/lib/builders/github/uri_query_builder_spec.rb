require 'rails_helper'

RSpec.describe Builders::Github::UriQueryBuilder do
  describe '#build' do
    context 'when no parameter is informed' do
      it 'builds uri query with default values' do
        query = described_class.build({})

        expect(query).to eq("q=language:ruby&sort=stars&order=desc&page=1&per_page=20")
      end
    end

    context 'when username is informed' do
      it 'builds uri query using the username' do
        params = { username: 'ramonlgr' }

        query = described_class.build(params)

        expect(query).to eq("q=language:ruby+user:ramonlgr&sort=stars&order=desc&page=1&per_page=20")
      end
    end

    context 'when language is informed' do
      it 'builds uri query using the language' do
        params = { language: 'cobol' }

        query = described_class.build(params)

        expect(query).to eq("q=language:cobol&sort=stars&order=desc&page=1&per_page=20")
      end
    end

    context 'when a keyword is informed' do
      it 'builds uri query using the keyword' do
        params = { q: 'batata' }

        query = described_class.build(params)

        expect(query).to eq("q=batata+language:ruby&sort=stars&order=desc&page=1&per_page=20")
      end
    end

    context 'when sort is informed' do
      context 'when sorted by stars' do
        it 'builds uri query with sort by stars' do
          params = { sort: 'stars' }

          query = described_class.build(params)

          expect(query).to eq("q=language:ruby&sort=stars&order=desc&page=1&per_page=20")
        end
      end

      context 'when sorted by forks' do
        it 'builds uri query with sort by forks' do
          params = { sort: 'forks' }

          query = described_class.build(params)

          expect(query).to eq("q=language:ruby&sort=forks&order=desc&page=1&per_page=20")
        end
      end

      context 'when sorted by update date' do
        it 'builds uri query with sort by updated' do
          params = { sort: 'updated' }

          query = described_class.build(params)

          expect(query).to eq("q=language:ruby&sort=updated&order=desc&page=1&per_page=20")
        end
      end
    end

    context 'when oder is informed' do
      context 'when asc' do
        it 'builds uri query with sort by stars' do
          params = { order: 'asc' }

          query = described_class.build(params)

          expect(query).to eq("q=language:ruby&sort=stars&order=asc&page=1&per_page=20")
        end
      end

      context 'when desc' do
        it 'builds uri query with sort by stars' do
          params = { order: 'desc' }

          query = described_class.build(params)

          expect(query).to eq("q=language:ruby&sort=stars&order=desc&page=1&per_page=20")
        end
      end
    end
  end
end
