# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::MediaGallery::ItemsController, type: :controller do
  routes { Api::Engine.routes }

  let(:params) { {} }
  let(:action) { :index }

  describe "GET #index" do
    context "when format JSON" do
      let(:send_request) { get :index, params: params, format: "json" }

      it "responds with status 'ok' and correct body json", :aggregate_failures do
        send_request

        expect(response).to have_http_status(:ok)
        expect(response).to match_json_schema("admin/media_gallery/items")
      end
    end
  end
end
