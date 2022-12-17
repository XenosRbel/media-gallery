# frozen_string_literal: true

RSpec.shared_examples :remote_entity_block_serializer do
  describe "#as_json" do
    let(:entity_plural_name) { entity_name.pluralize }
    let(:object) do
      {
        "#{entity_plural_name}_path": FFaker::Internet.http_url,
        feedback_form_id: "1",
        "#{entity_name}_path_mask": FFaker::Internet.http_url
      }
    end
    let(:expected_result) { object }
    let(:result) { serializer.as_json }

    it "returns correct json" do
      expect(result).to include(expected_result)
    end

    context "when values are absent" do
      let(:object) { { "#{entity_plural_name}_path": "", feedback_form_id: "", "#{entity_name}_path_mask": "" } }
      let(:expected_result) do
        {
          "#{entity_plural_name}_path": "/#{entity_plural_name}",
          feedback_form_id: "",
          "#{entity_name}_path_mask": "/api/v1/public/#{entity_plural_name}/{:id}"
        }
      end

      it "returns json with default values" do
        expect(result).to include(expected_result)
      end
    end
  end
end
