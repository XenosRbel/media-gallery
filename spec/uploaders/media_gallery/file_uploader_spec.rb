# frozen_string_literal: true

require "rails_helper"

RSpec.describe MediaGallery::FileUploader do
  let(:file_name) { "1" }
  let(:media_gallery_file_item) do
    build_stubbed(:media_gallery_file,
                  item: nil,
                  filesize: nil,
                  width: nil,
                  height: nil,
                  name: file_name)
  end
  let(:uploader) { described_class.new(media_gallery_file_item, :file) }
  let(:store) { uploader.store!(file) }

  before { described_class.enable_processing = true }

  after do
    uploader.remove!
    described_class.enable_processing = false
  end

  context "image file" do
    let(:file) { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "1.jpg"), "image/jpeg") }
    let(:dimensions) { MiniMagick::Image.open(file.path).dimensions }

    before { allow(FFMPEG::Movie).to receive(:new).and_call_original }

    it "returns self on original_image_version" do
      store
      expect(uploader.original_image_version).to eq(uploader)
    end

    it "have thumbnail_image version", :aggregate_failures do
      store
      expect(uploader.version_exists?(:thumbnail_image)).to be(true)
      expect(uploader.thumb).to eq(uploader.thumbnail_image)
    end

    it "does not process with video library" do
      store
      expect(FFMPEG::Movie).not_to have_received(:new)
    end

    it "sets file width to model" do
      expect { store }.to change(media_gallery_file_item, :width).from(nil).to(dimensions[0])
    end

    it "sets file height to model" do
      expect { store }.to change(media_gallery_file_item, :height).from(nil).to(dimensions[1])
    end
  end

  context "video file" do
    let(:file) { Rack::Test::UploadedFile.new(Rails.root.join("spec", "fixtures", "video.mp4"), "video/mp4") }
    let(:video) { FFMPEG::Movie.new(file.path) }
    let(:dimensions) { [video.width, video.height] }

    let(:expected_video_thumbnail_image_url) { "video_thumbnail_image_#{uploader.filename.gsub('mp4', 'jpg')}" }

    before { allow(MiniMagick::Image).to receive(:open).and_call_original }

    it "has original_image version", :aggregate_failures do
      store
      expect(uploader.version_exists?(:original_image)).to be(true)
      expect(uploader.original_image_version).to eq(uploader.original_image)
    end

    it "has original_image url" do
      store
      expect(uploader.original_image.url).to end_with "original_image_#{uploader.filename.gsub('mp4', 'jpg')}"
    end

    it "has video_thumbnail_image version", :aggregate_failures do
      store
      expect(uploader.version_exists?(:video_thumbnail_image)).to be(true)
      expect(uploader.thumb).to eq(uploader.video_thumbnail_image)
    end

    it "has video_thumbnail_image url" do
      store
      expect(uploader.video_thumbnail_image.url).to end_with(expected_video_thumbnail_image_url)
    end

    it "does not process with image library" do
      store
      expect(MiniMagick::Image).not_to have_received(:open)
    end

    it "sets file width to model" do
      expect { store }.to change(media_gallery_file_item, :width).from(nil).to(dimensions[0])
    end

    it "sets file height to model" do
      expect { store }.to change(media_gallery_file_item, :height).from(nil).to(dimensions[1])
      expect(uploader.type).to eq(:video)
    end
  end
end
