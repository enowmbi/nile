module Api
  module V1
    class AuthorsController < ApplicationController
      before_action :set_author, only: %i[show]
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
      end

      def update
      end

      def destroy
      end

      private

      def set_author
        @author = Author.find(params[:id])
      end
    end
  end
end
