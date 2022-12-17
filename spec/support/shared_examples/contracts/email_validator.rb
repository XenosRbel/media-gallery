# frozen_string_literal: true

RSpec.shared_examples_for :email_validator do |max_length:|
  describe "email" do
    context "when value is too long" do
      let(:params) { super().merge("email" => FFaker::Lorem.characters(max_length + 1)) }
      let(:error_string) { "Слишком большой длины (количество символов не должно превышать #{max_length})" }

      it "fails with 'max_size?' error", :aggregate_failures do
        expect(result).to be_failure
        expect(result.errors[:email]).to eq([error_string])
      end
    end

    context "when invalid value format" do
      let(:invalid_email) { FFaker::Lorem.word }
      let(:params) { super().merge("email" => invalid_email) }

      it "fails with 'format?' error", :aggregate_failures do
        expect(result).to be_failure
        expect(result.errors[:email]).to eq(["Имеет неверное значение"])
      end
    end
  end
end
