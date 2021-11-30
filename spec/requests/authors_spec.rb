require 'rails_helper'

RSpec.describe "Authors", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/authors/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/authors/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/authors/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/authors/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/authors/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
