module Api
  module V1
    class AuthController < ApplicationController
      # Skip authentication for login
      skip_before_action :authenticate_request, only: [ :login, :signup ]

      # POST /api/v1/login
      def login
        # Expect JSON payload with email and password
        puts params[:email], params[:password]
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
          token = JsonWebToken.encode(user_id: user.id)
          render json: { token: token, user: user }, status: :ok
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end
      # POST /api/v1/signup
      def signup
        user = User.new(signup_params)
        if user.save
          # Optionally, create an author profile automatically:
          # Uncomment the following line if you want to create an empty author profile
          user.create_author

          token = JsonWebToken.encode(user_id: user.id)
          render json: { token: token, user: user }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def signup_params
        params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
      end
    end
  end
end
