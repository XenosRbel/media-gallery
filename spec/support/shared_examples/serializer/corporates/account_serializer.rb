# frozen_string_literal: true

RSpec.shared_examples :account_serializer do |account_type:|
  subject(:serializer) { described_class.new(records, options) }

  describe "#serializable_hash" do
    let(:object) { build_stubbed(account_type) }
    let(:records) { [object] }
    let(:options) { { meta: meta, is_collection: true, params: params } }
    let(:meta) { { totalPages: 1, availableSources: available_sources } }
    let(:available_sources) { %i[nrd euroclear] }
    let(:params) { { edit_path_helper: edit_path_helper } }
    let(:edit_path_helper) { double("edit_path_helper") }
    let(:edit_path) { FFaker::Internet.http_url }
    let(:type) { :"#{account_type.camelize(:lower)}" }

    let(:result) { serializer.serializable_hash }

    let(:object_hash) do
      {
        data: [
          {
            id: object.id.to_s,
            type: type,
            attributes: {
              value: object.value,
              source: object.source
            },
            links: { editPath: edit_path }
          }
        ],
        meta: meta
      }
    end

    before { allow(edit_path_helper).to receive(:call).with(object).and_return(edit_path) }

    it "returns serializable hash" do
      expect(result).to eq(object_hash)
    end
  end
end
