# frozen_string_literal: true

RSpec.shared_examples_for :verified_amounts do
  before { post action, params: params }

  context "when params with basic amount" do
    context "and without premium amount" do
      let(:discount_params) { valid_attributes.merge(premium_amount: nil) }

      it_behaves_like :check_discount_params, :basic_amount
    end

    context "and with premium amount" do
      let(:discount_params) { valid_attributes }

      it_behaves_like :check_discount_params, :premium_amount
    end
  end

  context "when params without basic amount" do
    let(:discount_params) { valid_attributes.merge(basic_amount: nil) }

    it_behaves_like :check_discount_params, :premium_amount
  end
end

shared_examples_for :check_discount_params do |field|
  it "updates params" do
    expect(assigns(:discount_params)[:premium_amount]).to eq(discount_params[field].to_s)
  end

  it "sets discount premium amount" do
    expect(assigns(:discount).premium_amount).to eq(discount_params[field])
  end
end
