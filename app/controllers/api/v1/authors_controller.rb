module Api
  module V1
    class AuthorsController < ApplicationController
      before_action :set_author, only: %i[show update destroy]
      def index
        authors = Author
          .all
          .limit(limit)
          .offset(offset)

        render json: authors
      end

      def show
        render json: @author
      end

      def create
        author = Author.new(author_params)
        if author.save
          render json: author, status: :created
        else
          render json: author.errors.full_error_messages, status: :unprocessable_entity
        end
      end

      def update
        if @author.update(author_params)
          render json: @author
        else
          render json :@author.errors.full_error_messages, status: :unprocessable_entity
        end
      end

      def destroy
       if @author.destroy
        head :no_content
       else
         render json: @author.errors.full_error_messages, status: :unprocessable_entity
       end
      end

      private

      def limit
        params.fetch(:limit, 50)
      end
      def offset
        params.fetch(:offset, 0)
      end

      def set_author
        @author = Author.find(params[:id])
      end

      def author_params
        params.require(:author).permit(:first_name, :last_name, :email)
      end

      def display_record_not_found_error_message
        render json: {error: "Author with specified ID(#{params[:id]}) Not found"}, status: :not_found
      end
    end
  end
end
