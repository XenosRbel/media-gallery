require 'rails_helper'

RSpec.describe "Api::V1::MediaGallery::Folders", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/api/v1/media_gallery/folders/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/api/v1/media_gallery/folders/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/api/v1/media_gallery/folders/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
