# frozen_string_literal: true

RSpec.shared_examples_for :contracts_greater_than_validator do |params_key:, compared_value:|
  context "when bonuses_total_amount is 0" do
    let(params_key.to_s.underscore.to_sym) { 0 }

    it "returns gt? error", :aggregate_failures do
      expect(result).to be_failure
      expect(result.errors[params_key]).to eq(["Должно быть больше чем #{compared_value}"])
    end
  end
end
