# frozen_string_literal: true

RSpec.shared_examples_for :contracts_non_string_params_values do |errors_keys:|
  context "when params value is not string" do
    errors_keys.each do |key|
      let(key.to_s.underscore.to_sym) { 123 }
    end

    it "is fails with 'str?' error", :aggregate_failures do
      expect(result).to be_failure
      expect(result.errors.to_h.keys).to match_array(errors_keys)

      errors_keys.each do |key|
        expect(result.errors[key]).to eq(["Не является строкой"])
      end
    end
  end
end
