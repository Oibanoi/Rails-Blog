module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_comment, only: [ :show, :update, :destroy ]
      before_action :set_blog, only: [ :index, :create ]

      # GET /api/v1/blogs/:blog_id/comments
      def index
        @comments = @blog.comments
        render json: @comments
      end

      # GET /api/v1/comments/:id
      def show
        render json: @comment
      end

      # POST /api/v1/blogs/:blog_id/comments
      def create
        @comment = @blog.comments.new(comment_params)
        # Optionally, assign a user id if using authentication:
        # @comment.user_id = current_user.id if defined?(current_user)
        if @comment.save
          render json: @comment, status: :created
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/comments/:id
      def update
        if @comment.update(comment_params)
          render json: @comment
        else
          render json: @comment.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/comments/:id
      def destroy
        @comment.destroy
        head :no_content
      end

      private

      def set_comment
        @comment = Comment.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Comment not found" }, status: :not_found
      end

      def set_blog
        @blog = Blog.find(params[:blog_id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Blog not found" }, status: :not_found
      end

      def comment_params
        params.require(:comment).permit(:content, :user_id)
      end
    end
  end
end
