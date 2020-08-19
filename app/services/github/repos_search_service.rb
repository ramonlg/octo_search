require 'net/http'
require 'builders/github/uri_query_builder'
require 'json_parsers/github/repos_search_parser'

module Github
  class ReposSearchService < ApplicationService
    def call
      response = Net::HTTP.get_response(uri)
      parse_items(response.body)
    end

    private

    attr_reader :params

    def uri
      @uri ||= URI('https://api.github.com/search/repositories')
      @uri.query = build_uri_query

      @uri
    end

    def build_uri_query
      Builders::Github::UriQueryBuilder.build(params)
    end

    def parse_items(response_body)
      JsonParsers::Github::ReposSearchParser.parse(response_body)
    end
  end
end
