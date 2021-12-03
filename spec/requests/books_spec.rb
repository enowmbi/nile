require 'rails_helper'

RSpec.describe "Books", type: :request do
    let!(:all) do
      FactoryBot.create(:book)
    end

    after(:all) do 
      Author.destroy_all
    end

    describe "GET /api/v1/index" do
      before(:each){ get "/api/v1/books/" }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns a response of JSON content" do
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end

      it "returns the correct number of entries in database" do
        expect(JSON.parse(response.body).size).to eq(1)
      end
    end

  describe "GET /api/v1/books/id" do
    let!(:book){ Book.first }
    before(:each){ get "/api/v1/books/#{book.id}" }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns selected book as JSON" do
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it "returns only selected book" do
      expect([JSON.parse(response.body)].size).to eq(1)
    end
  end

  describe "POST /api/v1/books" do
    let!(:author) do 
      FactoryBot.create(
        :author,
        first_name: "John",
        last_name: "Doe",
        email: "john_doe@example.com"
      )
    end

    let!(:valid_params) do
      {
        book: {
          title: "Writing Clean Code",
          author_id: author.id,
          published_date: 1.year.ago
        }
      }
    end

    let!(:valid_params2) do
      {
        book: {
          title: "The little things",
          author_id: author.id,
          published_date: 1.year.ago
        }
      }
    end

    before(:each){ post "/api/v1/books", params: valid_params }

    it "returns http created" do
      expect(response).to have_http_status(:created)
    end

    it "increments book collection by one" do
      expect{post "/api/v1/books", params: valid_params2 }.to change(Book, :count).by(1)
    end

    it "returns the last book created" do
      expect(JSON.parse(response.body)["id"]).to eq(Book.last.id)
    end

    it "returns the created book as json" do
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end

  describe "Put /api/v1/books/id" do
    let!(:book){ FactoryBot.create(:book, title: "Refactory Stages") }

    let!(:valid_params) do
      {
        book: {
          title: "Writing Clean Code",
        }
      }
    end

    before(:each){ put "/api/v1/books/#{book.id}", params: valid_params }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns updated book as JSON" do
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it "returns only updated book" do
      expect([JSON.parse(response.body)].size).to eq(1)
      expect(JSON.parse(response.body)["title"]).to eq("Writing Clean Code")
    end
  end

  xdescribe "Delete /api/v1/authors/id" do
    let!(:last){ Author.last }

    it "returns decrements authors count by one and return no_content response" do
      expect{ delete "/api/v1/authors/#{last.id}" }.to change(Author, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
