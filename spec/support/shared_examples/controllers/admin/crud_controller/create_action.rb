# frozen_string_literal: true

require_relative "./limited_access_action.rb"

RSpec.shared_examples_for :create_action do
  describe "POST create" do
    let(:params) { default_params.merge(param_key => valid_attributes) }
    let(:send_request) { post :create, params: params, session: valid_session }

    describe "with valid params" do
      it "creates a new item" do
        expect { send_request }.to change(item_type, :count).by(1)
      end

      it "assigns a newly created item" do
        send_request
        expect(assigns(item_name)).to be_a(item_type)
        expect(assigns(item_name)).to be_persisted
      end

      it "redirects to the index" do
        send_request
        expect(response).to redirect_to(after_create_redirection || index_path)
      end
    end

    describe "with invalid params" do
      let(:params) { default_params.merge(param_key => invalid_attributes) }

      it "assigns a newly created but unsaved item" do
        send_request
        expect(assigns(item_name)).to be_a_new(item_type)
      end

      it "re-renders the 'new' template" do
        send_request
        expect(response).to render_template("new")
      end
    end

    it_behaves_like :limited_access_action do
      let(:successful_response) { redirect_to(after_create_redirection || index_path) }
    end
  end
end
