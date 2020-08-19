module JsonParsers
  module Github
    class ReposSearchParser
      private_class_method :new

      def self.parse(response_body)
        new(response_body).parse_response
      end

      def initialize(response_body)
        @response_body = response_body
      end

      def parse_response
        { repositories: repositories_data }
      end

      private

      attr_reader :response_body

      def repositories_data
        items.map do |item|
          build_repository(item)
        end
      end

      def items
        @items ||= parsed['items']
      end

      def parsed
        @parsed ||= JSON.parse(response_body)
      end

      def build_repository(item)
        {
          name: item['name'],
          description: item['description'] ,
          stars: item['stargazers_count'] ,
          forks: item['forks'] ,
          author: item['owner']['login']
        }
      end
    end
  end
end
