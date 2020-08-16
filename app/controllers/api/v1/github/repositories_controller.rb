module Api
  module V1
    module Github
      class RepositoriesController < ApplicationController
        def index
          render json: repositories, status: :ok
        end

        private

        def repositories
          @repositories ||= ::Github::ReposSearchService.call(search_params)
        end

        def search_params
          params.permit(
            :q, :username, :language, :sort, :order, :page, :per_page
          )
        end
      end
    end
  end
end

