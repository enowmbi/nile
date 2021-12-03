require 'rails_helper'

RSpec.describe "Authors", type: :request do
    before(:all) do
      FactoryBot.create_list(:author, 3)
    end

    after(:all) do 
      Author.destroy_all
    end

    describe "GET /api/v1/index" do
      before(:each){ get "/api/v1/authors/" }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "returns a response of JSON content" do
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end

      it "returns the correct number of entries in database" do
        expect(JSON.parse(response.body).size).to eq(3)
      end
    end

  describe "GET /api/v1/id" do
    let!(:second){ Author.second }
    before(:each){ get "/api/v1/authors/#{second.id}" }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns selected author as JSON" do
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it "returns only selected author" do
      expect([JSON.parse(response.body)].size).to eq(1)
    end
  end

  describe "GET /api/v1/create" do
    let!(:valid_params) do
      {
        author: {
          first_name: "John",
          last_name: "Doe",
          email: "john_doe@example.com"
        }
      }
    end

    let!(:valid_params2) do
      {
        author: {
          first_name: "Jane",
          last_name: "Doe",
          email: "jane_doe@example.com"
        }
      }
    end

    before(:each){ post "/api/v1/authors", params: valid_params }

    it "returns http created" do
      expect(response).to have_http_status(:created)
    end

    it "increments the authors collection by one" do
      expect{post "/api/v1/authors", params: valid_params2 }.to change(Author, :count).by(1)
    end

    it "returns the last author created" do
      expect(JSON.parse(response.body)["id"]).to eq(Author.last.id)
    end

    it "returns the created author as json" do
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end
  end

  describe "Put /api/v1/authors/id" do
    let!(:first){ Author.first }
    let!(:valid_params) do
      {
        author: {
          first_name: "James",
          last_name: "Bond",
          email: "james_bond@goldfinger.net"
        }
      }
    end

    before(:each){ put "/api/v1/authors/#{first.id}", params: valid_params }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns selected author as JSON" do
      expect(response.content_type).to eq("application/json; charset=utf-8")
    end

    it "returns only updated author" do
      expect([JSON.parse(response.body)].size).to eq(1)
      expect(JSON.parse(response.body)["first_name"]).to eq("James")
      expect(JSON.parse(response.body)["last_name"]).to eq("Bond")
      expect(JSON.parse(response.body)["email"]).to eq("james_bond@goldfinger.net")
    end
  end

  describe "Delete /api/v1/authors/id" do
    let!(:last){ Author.last }

    it "returns decrements authors count by one and return no_content response" do
      expect{ delete "/api/v1/authors/#{last.id}" }.to change(Author, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
