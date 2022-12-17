# frozen_string_literal: true

RSpec.shared_examples_for :new_year_reports_contract do |tag_code:, tag_priority:|
  describe ".tag_priority" do
    it "has valid tag priority" do
      expect(described_class.tag_priority).to eq(tag_priority)
    end
  end

  describe "#call" do
    context "when params are valid" do
      it "is successful" do
        expect(result).to be_success
      end
    end

    context "when tag value is false" do
      let(:params) { super().merge(tag_code => false) }

      it "is failed with 'true?' error", :aggregate_failures do
        expect(result).to be_failure
        expect(result.errors[tag_code]).to eq(["Не является истиной"])
      end
    end
  end
end
