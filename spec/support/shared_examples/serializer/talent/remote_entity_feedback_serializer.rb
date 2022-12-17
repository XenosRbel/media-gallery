# frozen_string_literal: true

RSpec.shared_examples :remote_entity_feedback_serializer do
  describe "to_hash" do
    let(:object) { build_stubbed(object_factory_name) }
    let(:result) { serializer.to_hash }

    let(:object_hash) do
      {
        data: {
          id: object.id.to_s,
          type: type,
          attributes: {
            status: object.status,
            email: object.email,
            phone: object.phone,
            additionalInfo: object.additionalInfo,
            university: object.university,
            universityYear: object.universityYear,
            candidateName: "#{object.firstName} #{object.lastName}",
            feedbackDate: Date.parse(object.createdDate).strftime("%d.%m.%Y"),
            cv: nil
          }
        }
      }
    end

    it "returns hash" do
      expect(result).to eq(object_hash)
    end

    context "when cv_id attribute not nil" do
      let(:object) { build_stubbed(object_factory_name, cvId: "0") }
      let(:object_hash) do
        super().deep_merge(data: { attributes: { cv: "#{feedback_type.element_path(object.id)}/cv" } })
      end

      it "returns hash with cv attribute" do
        expect(result).to eq(object_hash)
      end
    end
  end
end
