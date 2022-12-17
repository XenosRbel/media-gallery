# frozen_string_literal: true

RSpec.shared_examples :ds_block_serializer do
  describe "#as_json" do
    let(:params) { { camelize_keys: true, personalize: personalize, segment_personalized: segment_personalized } }

    let(:object) { { props: {} } }

    let(:result) { serializer.as_json }

    context "when personalize is true" do
      let(:personalize) { true }

      context "when segment_personalized is true" do
        let(:segment_personalized) { true }

        it "returns personalized: true" do
          expect(result).to eq({ personalized: true, blockKey: nil })
        end
      end

      context "when segment_personalized is false" do
        let(:segment_personalized) { false }

        it "returns personalized: false" do
          expect(result).to eq({ personalized: false, blockKey: nil })
        end
      end
    end

    context "when personalize is false" do
      let(:personalize) { false }
      let(:segment_personalized) { true }

      it "returns personalized: false" do
        expect(result).to eq({ personalized: false, blockKey: nil })
      end
    end
  end
end
