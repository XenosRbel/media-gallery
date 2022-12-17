# frozen_string_literal: true

require "rails_helper"

RSpec.describe ::MediaGallery::FolderContract, type: :contract do
  subject(:contract) { described_class.new }

  describe "#call" do
    let(:params) { attributes_for(:media_gallery_folder) }
    let(:result) { contract.call(params) }

    context "when passed the correct name and system_name params" do
      it "is successful" do
        expect(result).to be_success
      end
    end

    context "when passed invalid name param" do
      let(:invalid_name) { nil }
      let(:params) { super().merge("name" => invalid_name) }

      it "is failed", :aggregate_failures do
        expect(result).to be_failure
        expect(result.errors[:name]).to eq(["Не может быть пустым"])
      end
    end

    context "when name is not string" do
      let(:params) { super().merge("name" => FFaker::Random.rand) }

      it "is fails with 'string?' error", :aggregate_failures do
        expect(result).to be_failure
        expect(result.errors[:name]).to eq(["Не является строкой"])
      end
    end

    context "when passed invalid system_name param" do
      let(:invalid_system_name) { FFaker::LoremRU.word }
      let(:params) { super().merge("system_name" => invalid_system_name) }

      it "is failed", :aggregate_failures do
        expect(result).to be_failure
        expect(result.errors[:system_name]).to eq(["Имеет неверное значение"])
      end
    end

    context "when name is not string" do
      let(:params) { super().merge("system_name" => FFaker::Random.rand) }

      it "is fails with 'string?' error", :aggregate_failures do
        expect(result).to be_failure
        expect(result.errors[:system_name]).to eq(["Не является строкой"])
      end
    end

    context "when params is nil" do
      let(:params) { nil }

      it "is failed", :aggregate_failures do
        expect(result).to be_failure
        expect(result.errors[:name]).to eq(["Параметр отсутствует"])
        expect(result.errors[:system_name]).to eq(["Параметр отсутствует"])
      end
    end
  end
end
