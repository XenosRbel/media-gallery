# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::MediaGallery::FilesController, type: :controller do
  shared_context :media_gallery_file_processor do
    before do
      ::MediaGallery::FileUploader.enable_processing = true
    end

    after do
      ::MediaGallery::FileUploader.enable_processing = false
    end
  end

  routes { Api::Engine.routes }

  let(:item_name) { :file }

  describe "POST create" do
    include_context :media_gallery_file_processor

    let(:folder) { create(:media_gallery_folder) }
    let(:send_request) { post :create, params: params }

    context "when valid params" do
      let(:file) { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "1.jpg"), "image/jpeg") }
      let(:description) { "" }
      let(:params) { { item_name => { item: file, media_gallery_folder_id: folder.id, description: description } } }

      it "responds with status 'created' and correct body json", :aggregate_failures do
        send_request

        expect(response).to have_http_status(:created)
        expect(response).to match_json_schema("admin/media_gallery/file")
      end
    end

    context "when invalid params" do
      let(:params) { { item_name => { item: nil, media_gallery_folder_id: folder.id.to_s, description: nil } } }

      it "responds with status unprocessable_entity", :aggregate_failures do
        send_request

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to match_json_schema("admin/media_gallery/files/index/errors")
      end
    end
  end

  describe "PUT update" do
    include_context :media_gallery_file_processor

    let(:item) { build_stubbed(:media_gallery_file) }
    let(:item_type) { ::MediaGallery::File }
    let(:content_type) { "image/jpeg" }
    let(:description) { FFaker::LoremRU.word }
    let(:file) { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "1.jpg"), content_type) }
    let(:params) { { "id" => item.to_param, item_name => { "item" => file, "description" => description } } }

    let(:send_request) { put :update, params: params }

    before do
      allow(item_type).to receive(:find).with(item.id.to_s).and_return(item)
      allow(item).to receive(:update).and_return(item)
    end

    context "with valid params" do
      it "responds with status 'ok' and correct body json", :aggregate_failures do
        send_request

        expect(response).to have_http_status(:ok)
        expect(response).to match_json_schema("admin/media_gallery/file")
      end
    end

    context "with invalid params" do
      let(:content_type) { "video/mp4" }
      let(:description) { 123 }

      it "responds with status 'unprocessable_entity' and json body with errors", :aggregate_failures do
        send_request

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to match_json_schema("admin/media_gallery/files/index/errors")
      end
    end
  end

  describe "GET show" do
    let(:item) { build_stubbed(:media_gallery_file) }
    let(:item_type) { ::MediaGallery::File }

    let(:send_request) { get :show, format: "json", params: { id: item.id } }

    before do
      allow(item_type).to receive(:find).with(item.id.to_s).and_return(item)
    end

    context "when format JSON" do
      it "responds with status 'ok' and correct body json", :aggregate_failures do
        send_request

        expect(response).to have_http_status(:ok)
        expect(response).to match_json_schema("admin/media_gallery/file")
      end
    end
  end

  describe "DELETE destroy" do
    context "when passed id param" do
      let(:item) { build_stubbed(:media_gallery_file) }
      let(:params) { { "id" => item.to_param } }
      let(:item_type) { ::MediaGallery::File }

      let(:send_request) { delete :destroy, params: params }

      let(:file_destroyer) { instance_double(Admin::MediaGallery::File::Destroyer) }
      let(:destroyer_result) { instance_double(Admin::MediaGallery::File::DestroyResult) }

      before do
        allow(item_type).to receive(:find).with(item.id.to_s).and_return(item)

        allow(controller).to receive(:file_destroyer).and_return(file_destroyer)
        allow(file_destroyer).to receive(:call).and_return(destroyer_result)
        allow(destroyer_result).to receive(:success?).and_return(destroyer_result_success)
      end

      context "when file exist" do
        let(:destroyer_result_success) { true }

        it "responds with status 'No Content' and correct body json", :aggregate_failures do
          send_request

          expect(response).to have_http_status(:no_content)
          expect(response.body).to be_empty
        end
      end

      context "when file was not destroyed" do
        let(:destroyer_result_success) { false }

        let(:errors_hash) { { question: ["invalid"] } }
        let(:persistence_errors) { build(:media_gallery_file_persistence_errors, **errors_hash) }

        before do
          allow(destroyer_result).to receive(:failure).and_return(persistence_errors)
        end

        it "responds with status 'Unprocessable Entity' and errors json in body", :aggregate_failures do
          send_request

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to match_json_schema("admin/media_gallery/files/index/errors")
        end
      end
    end
  end

  describe "GET index" do
    let(:item) { build_stubbed(:media_gallery_file) }
    let(:params) { { name: item.name, file_ids: [item.id] } }

    let(:file_searcher) { instance_double(Admin::MediaGallery::File::Searcher) }
    let(:searcher_result_instance) do
      instance_double(Admin::MediaGallery::File::SearchResult, success?: true, value: [item], failure: nil)
    end

    let(:send_request) { get :index, format: "json", params: params }

    before do
      allow(controller).to receive(:file_searcher).and_return(file_searcher)
      allow(file_searcher).to receive(:call).and_return(searcher_result_instance)
    end

    context "when query is valid" do
      it "responds with status 'ok' and correct body json", :aggregate_failures do
        send_request

        expect(response).to have_http_status(:ok)
        expect(response).to match_json_schema("admin/media_gallery/files/index")
      end
    end

    context "when file searcher returns error messages" do
      let(:errors_hash) { { question: ["invalid"] } }
      let(:search_errors) { build(:media_gallery_file_search_errors, **errors_hash) }

      let(:send_request) { get :index, format: "json", params: params }

      before do
        allow(searcher_result_instance).to receive_messages(success?: false, value: [], failure: search_errors)
      end

      it "responds with 'Bad Request' status and errors json in body", :aggregate_failures do
        send_request

        expect(response).to have_http_status(:bad_request)
        expect(response).to match_json_schema("admin/media_gallery/files/index/errors")
      end
    end
  end
end
