module Api
  module V1
    class AuthorsController < ApplicationController
      before_action :set_author, only: [ :show, :update ]

      # GET /api/v1/authors
      # Returns the current user's author profile
      def show
        render json: @author
      end

      # PATCH/PUT /api/v1/authors
      # Updates the current user's author profile
      def update
        if @author.update(author_params)
          render json: { message: "Profile updated successfully", author: @author }
        else
          render json: { errors: author.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def set_author
        # Ensure the current user has an associated author profile
        if current_user.author.present?
          @author = current_user.author
        else
          render json: { error: "Author profile not found" }, status: :not_found
        end
      end

      def author_params
        params.require(:author).permit(:bio, :website)
      end
    end
  end
end
