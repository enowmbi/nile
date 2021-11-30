module Api
  module V1
    class AuthorsController < ApplicationController
      def index
        authors = Author
          .all
          .limit(limit)
          .offset(offset)

        render json: authors
      end

      def show
      end

      def create
      end

      def update
      end

      def destroy
      end
    end
  end
end
