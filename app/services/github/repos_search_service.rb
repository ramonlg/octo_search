require 'net/http'
require 'builders/github/uri_query_builder'

module Github
  class ReposSearchService
    private_class_method :new

    def self.call(params)
      new(params).execute
    end

    def initialize(params)
      @params ||= params
    end

    def execute
      response = Net::HTTP.get_response(uri)
      parse_items(response)
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

    def parse_items(response)
      parsed = JSON.parse(response.body)
    end
  end
end
