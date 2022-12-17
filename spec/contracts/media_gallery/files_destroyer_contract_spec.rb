# frozen_string_literal: true

require "rails_helper"

RSpec.describe ::MediaGallery::FilesDestroyerContract, type: :contract do
  subject(:contract) { described_class.new }

  describe "#call" do
    let(:ids) { [FFaker::Random.rand(1000)] }
    let(:params) { { "ids" => ids } }
    let(:result) { contract.call(params) }

    context "when valid ids params are passed" do
      it "is successful" do
        expect(result).to be_success
      end
    end

    it_behaves_like :contracts_non_integer_params_in_array, errors_keys: %i[ids]
    it_behaves_like :contracts_empty_params_values, errors_keys: %i[ids]
  end
end
