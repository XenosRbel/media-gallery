# frozen_string_literal: true

require "rails_helper"

RSpec.describe ::MediaGallery::SearcherFileContract, type: :contract do
  subject(:contract) { described_class.new }

  describe "#call" do
    let(:file_ids) { [FFaker::Random.rand(1..100)] }
    let(:name) { FFaker::Lorem.word }
    let(:params) { { "name" => name, "file_ids" => file_ids } }
    let(:result) { contract.call(params) }

    context "when valid name and file_ids params are passed" do
      it "is successful" do
        expect(result).to be_success
      end
    end

    context "when invalid file_ids param is passed" do
      let(:file_ids) { [FFaker::Lorem.word] }

      it "is failed", :aggregate_failures do
        expect(result).to be_failure
        expect(result.errors[:file_ids]).to eq({ 0 => ["Не является числом"] })
      end
    end

    context "when empty file_ids param is passed" do
      let(:file_ids) { [] }

      it "is failed", :aggregate_failures do
        expect(result).to be_failure
        expect(result.errors[:file_ids]).to eq(["Не может быть пустым"])
      end
    end

    it_behaves_like :contracts_non_string_params_values, errors_keys: %i[name]
  end
end
