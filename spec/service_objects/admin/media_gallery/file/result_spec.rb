# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::MediaGallery::File::Result, type: :model do
  subject(:result) { described_class.new(params) }

  describe "#success?" do
    let(:persistence_errors) { Admin::MediaGallery::File::PersistenceErrors.new }

    context "when params contain value with valid file instance" do
      let(:params) { { value: file } }
      let(:file) { ::MediaGallery::File.new }

      before { allow(file).to receive(:valid?).and_return(true) }

      it "result is a success" do
        expect(result).to be_success
      end

      context "when failure is not blank" do
        let(:params) { { value: file, failure: persistence_errors } }

        it "result is a failure" do
          expect(result).to be_failure
        end
      end

      context "when file model instance is not valid" do
        before { allow(file).to receive(:valid?).and_return(false) }

        it "result is a failure" do
          expect(result).to be_failure
        end
      end
    end

    context "when params contain failure" do
      let(:params) { { failure: persistence_errors } }

      it "result is a failure" do
        expect(result).to be_failure
      end
    end
  end
end
