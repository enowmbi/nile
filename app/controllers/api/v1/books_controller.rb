module Api
  module V1
    class BooksController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :display_record_not_found_error_message

      before_action :set_book, only: %i[show update destroy]

      def index
        books = Book
          .all
          .limit(limit)
          .offset(offset)

        render json: books
      end

      def show
        render json: @book
      end

      def create
        SendMailsWorker.new.perform_async(100_000_000)
        book = Book.new(book_params)
        if book.save!
          render json: book, status: :created
        else
          render json: book.errors, status: :unprocessable_entity
        end
      end

      def update
        if @book.update(book_params)
          render json: @book
        else
          render json: @book.errors.full_messages
        end
      end

      def destroy
        if @book.destroy!
          head :no_content
        else
          render(json: @book.errors.full_messages, status: :unprocessable_entity)
        end
      end

      private

      def book_params
        params.require(:book).permit(:title, :author, :published_date)
      end

      def set_book
        @book = Book.find(params[:id])
      end

      def limit
        params[:limit] || 25
      end

      def offset
        (params[:page].to_i * params[:limit].to_i) || 0
      end

      def display_record_not_found_error_message
        render json: {error: "Book with specified ID(#{params[:id]}) Not found"}, status: :not_found
      end
    end
  end
end
