# frozen_string_literal: true

require "rails_helper"

RSpec.describe ::MediaGallery::FileNameSanitizer, type: :service do
  subject(:service) { described_class.new(transliteration_service: transliteration_service) }

  let(:transliteration_service) { class_double(Russian) }

  describe "#call" do
    let(:actual_value) { service.call(original_filename) }

    context "when original filename is present" do
      let(:extension) { FFaker::Filesystem.extension }
      let(:file_name) { FFaker::LoremRU.word }
      let(:original_filename) { "#{file_name}.#{extension}" }
      let(:expected_value) { FFaker::Lorem.word }

      before do
        allow(transliteration_service).to receive(:translit).with(file_name.upcase).and_return(expected_value)
      end

      it "returns sanitized name" do
        expect(actual_value).to eq(expected_value)
      end
    end

    context "when original filename is blank" do
      let(:expected_value) { nil }
      let(:original_filename) { nil }

      it "returns empty sanitized name" do
        expect(actual_value).to eq(expected_value)
      end
    end
  end
end
