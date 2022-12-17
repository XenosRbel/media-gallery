# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::MediaGallery::FoldersController, type: :controller do
  routes { Api::Engine.routes }

  let(:item_name) { :folder }

  describe "POST create" do
    let(:send_request) { post :create, params: params }

    context "when valid params" do
      let(:params) { { item_name => attributes_for(:media_gallery_folder) } }

      it "responds with status 'created' and correct body json", :aggregate_failures do
        send_request

        expect(response).to have_http_status(:created)
        expect(response).to match_json_schema("admin/media_gallery/folder")
      end
    end

    context "when invalid params" do
      let(:params) { { item_name => attributes_for(:media_gallery_folder).merge(system_name: nil, name: nil) } }

      it "responds with status unprocessable_entity", :aggregate_failures do
        send_request

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to match_json_schema("admin/media_gallery/folders/index/errors")
      end
    end
  end

  describe "PUT update" do
    let(:item_type) { ::MediaGallery::Folder }
    let(:folder) { build_stubbed(:media_gallery_folder) }
    let(:params) { { "id" => folder.to_param, item_name => updated_folder_attributes } }
    let(:new_name) { FFaker::LoremRU.word }
    let(:updated_folder_attributes) do
      folder.attributes.merge("name" => new_name).except("created_at", "updated_at")
    end

    let(:send_request) { put :update, params: params }

    before do
      allow(item_type).to receive(:find).with(folder.id.to_s).and_return(folder)
      allow(folder).to receive(:update).and_return(folder)
    end

    context "with valid params" do
      it "responds with status 'ok' and correct body json", :aggregate_failures do
        send_request

        expect(response).to have_http_status(:ok)
        expect(response).to match_json_schema("admin/media_gallery/folder")
      end
    end

    context "with invalid params" do
      let(:new_name) { nil }

      it "responds with status 'unprocessable_entity' and correct body json", :aggregate_failures do
        send_request

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to match_json_schema("admin/media_gallery/folders/index/errors")
      end
    end
  end

  describe "DELETE#destroy" do
    let(:params) { { "id" => item.to_param } }
    let(:item_type) { ::MediaGallery::Folder }

    before do
      allow(item_type).to receive(:find).with(item.id.to_s).and_return(item)
      allow(item).to receive(:destroy).and_return(item)
      delete :destroy, params: params
    end

    context "when with valid params" do
      let(:item) { build_stubbed(:media_gallery_folder) }

      it "responds with status 'ok' and correct body json", :aggregate_failures do
        expect(response).to have_http_status(:ok)
        expect(response).to match_json_schema("admin/media_gallery/folder")
      end
    end

    context "when folder have files" do
      let(:item) { build_stubbed(:media_gallery_folder, :with_files) }

      it "responds with status 'Bad Reques' and errors json in body", :aggregate_failures do
        expect(response).to have_http_status(:bad_request)
        expect(response).to match_json_schema("admin/media_gallery/folders/index/errors")
      end
    end
  end
end
