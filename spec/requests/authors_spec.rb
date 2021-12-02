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
    before(:all){ @second = Author.second }
    before(:each){ get "/api/v1/authors/#{@second.id}" }

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

  xdescribe "GET /update" do
    it "returns http success" do
      get "/authors/update"
      expect(response).to have_http_status(:success)
    end
  end

  xdescribe "GET /destroy" do
    it "returns http success" do
      get "/authors/destroy"
      expect(response).to have_http_status(:success)
    end
  end
end
