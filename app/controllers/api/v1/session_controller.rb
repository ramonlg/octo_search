module Api
  module V1
    class SessionController < ApplicationController
      skip_before_action :authenticate_request

      def create
        user_auth = UserAuthenticationService.call(
          { username: params[:username], password: params[:password] }
        )

        render json: user_auth[:content], status: user_auth[:status]
      end
    end
  end
end