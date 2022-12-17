# frozen_string_literal: true

RSpec.shared_examples_for :phone_number_validator do
  describe "phone_number" do
    context "when invalid value format" do
      let(:invalid_phone_number) { FFaker::Lorem.word }
      let(:params) { super().merge("phone_number" => invalid_phone_number) }

      it "fails with 'format?' error", :aggregate_failures do
        expect(result).to be_failure
        expect(result.errors[:phone_number]).to eq(["Имеет неверное значение"])
      end
    end
  end
end
