# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::MediaGallery::File::DestroyResult, type: :model do
  subject(:result) { described_class.new(params) }

  describe "#success?" do
    let(:persistence_errors) { Admin::MediaGallery::File::PersistenceErrors.new }

    context "when params contain valid value" do
      let(:params) { { value: value } }
      let(:value) { true }

      it "returns success" do
        expect(result).to be_success
      end

      context "when failure is not blank" do
        let(:params) { { value: value, failure: persistence_errors } }

        it "returns failure" do
          expect(result).to be_failure
        end
      end
    end

    context "when params contain failure" do
      let(:params) { { failure: persistence_errors } }

      it "returns failure" do
        expect(result).to be_failure
      end
    end
  end
end
