# frozen_string_literal: true

RSpec.shared_examples_for :contracts_non_integer_params_in_array do |errors_keys:|
  context "when params value is not integer" do
    errors_keys.each do |key|
      let(key.to_s.underscore.to_sym) { [FFaker::Lorem.word] }
    end

    it "is fails with 'filled?' error", :aggregate_failures do
      expect(result).to be_failure
      expect(result.errors.to_h.keys).to match_array(errors_keys)

      errors_keys.each do |key|
        expect(result.errors[key]).to eq({ 0 => ["Не является числом"] })
      end
    end
  end
end
