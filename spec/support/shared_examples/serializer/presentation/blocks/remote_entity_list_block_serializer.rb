# frozen_string_literal: true

RSpec.shared_examples :remote_entity_list_block_serializer do
  describe "#as_json" do
    let(:entity_plural_name) { entity_name.pluralize }
    let(:list_path_name) { :"#{entity_name}_list_path" }
    let(:path_mask_name) { :"#{entity_name}_path_mask" }
    let(:list_path_value) { FFaker::Internet.http_url }
    let(:path_mask_value) { FFaker::Internet.http_url }
    let(:object) { { list_path_name => list_path_value, path_mask_name => path_mask_value } }
    let(:expected_result) { object }
    let(:result) { serializer.as_json }

    it "returns correct json" do
      expect(result).to include(expected_result)
    end

    context "when values are absent" do
      let(:list_path_value) { "" }
      let(:path_mask_value) { "" }
      let(:expected_result) do
        {
          list_path_name => "/#{entity_plural_name}",
          path_mask_name => "/#{entity_plural_name}/{:id}"
        }
      end

      it "returns json with default values" do
        expect(result).to include(expected_result)
      end
    end
  end
end
