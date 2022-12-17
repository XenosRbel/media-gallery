# frozen_string_literal: true

RSpec.shared_examples_for :contracts_blank_params do |errors_keys:|
  context "when params is blank" do
    let(:params) { {} }

    it "is failed with 'key?' error", :aggregate_failures do
      expect(result).to be_failure
      expect(result.errors.to_h.keys).to match_array(errors_keys)

      errors_keys.each do |key|
        expect(result.errors[key]).to eq(["Параметр отсутствует"])
      end
    end
  end
end
