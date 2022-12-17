# frozen_string_literal: true

RSpec.shared_examples_for :limited_access_action do
  describe "access check" do
    let(:user) { build_stubbed(:admin_user, role: role) }
    let(:ability) { Abilities::Factory.build(user) }
    let(:private_role_with_access) { try(:role_with_access) || "admin" }
    let(:private_role_without_access) { try(:role_without_access) || "lukoil_managers_editor" }

    before do
      allow(controller).to receive(:current_ability).with(no_args).and_return(ability)
      controller.extend(Admin::Engine.routes.url_helpers)
      sign_in(user)
    end

    context "when a user has role with access" do
      let(:role) { private_role_with_access }

      it "allows access to the resource" do
        send_request
        is_expected.to successful_response
      end
    end

    context "when user does not have access to the resource" do
      let(:role) { private_role_without_access }

      it "redirects to the root page" do
        send_request
        is_expected.to redirect_to(root_path)
      end
    end

    context "when user has not logged in" do
      let(:role) { private_role_with_access }

      before { sign_out(user) }

      it "redirects to sign_in page" do
        send_request
        is_expected.to redirect_to(new_user_session_path)
      end
    end
  end
end
