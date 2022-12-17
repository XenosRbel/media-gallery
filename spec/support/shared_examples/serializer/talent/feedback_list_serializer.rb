# frozen_string_literal: true

RSpec.shared_examples :feedback_list_serializer do
  describe "#to_hash" do
    let(:records) { [object] }
    let(:options) { { is_collection: true, params: params } }
    let(:params) { { show_path_helper: show_path_helper } }
    let(:show_path_helper) { double("show_path_helper") }
    let(:links) { { showPath: FFaker::Internet.http_url } }
    let(:result) { serializer.to_hash }

    let(:object_hash) do
      {
        data: [
          {
            id: object.id.to_s,
            type: type,
            attributes: {
              status: object.status,
              candidateName: "#{object.firstName} #{object.lastName}",
              feedbackDate: Date.parse(object.createdDate).strftime("%d.%m.%Y")
            },
            links: links
          }
        ]
      }
    end

    before { allow(show_path_helper).to receive(:call).with(object).and_return(links[:showPath]) }

    it "returns correct hash" do
      expect(result).to eq(object_hash)
    end
  end
end
