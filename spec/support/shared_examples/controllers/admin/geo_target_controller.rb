# frozen_string_literal: true

RSpec.shared_examples_for :geo_target_controller do
  describe "PUT update" do
    describe "with params" do
      it "allow geo_restriction_attributes" do
        expect(controller.__send__(params_method).last).to include(
          geo_restriction_attributes: GeoRestriction::ATTRIBUTES
        )
      end
    end
  end
end
