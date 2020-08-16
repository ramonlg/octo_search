module Builders
  module Github
    class UriQueryBuilder
      private_class_method :new

      def self.build(params)
        new(params).build_uri_query
      end

      def initialize(params)
        @keywords = params[:q]
        @username = params[:username]
        @language = params[:language] || 'ruby'
        @sort = params[:sort] || 'stars'
        @order = params[:order] || 'desc'
        @page = params[:page] || 1
        @per_page = params[:per_page] || 20
      end

      def build_uri_query
        {
          q: formatted_query,
          sort: sort,
          order: order,
          page: page,
          per_page: per_page
        }.map{ |k, v| "#{k}=#{v}" }.join("&")
      end

      private

      attr_reader :keywords, :username, :language, :sort, :order, :page, :per_page

      def formatted_query
        [
          keywords,
          formatted_language,
          formatted_username
        ].compact.join('+')
      end

      def formatted_language
        return nil unless language.present?

        "language:#{language}"
      end

      def formatted_username
        return nil unless username.present?

        "user:#{username}"
      end
    end
  end
end