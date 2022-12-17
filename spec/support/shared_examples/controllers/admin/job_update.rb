# frozen_string_literal: true

RSpec.shared_examples_for :admin_controller_job_update do
  before do
    allow(model_class).to receive(:find).with(record.id.to_s).and_return(record)
    allow(job_class).to receive(:perform_later)
  end

  it "starts update job", :aggregate_failures do
    send_request

    expect(job_class).to have_received(:perform_later).with(record_identifier)
    expect(response).to redirect_to(root_path)
    expect(controller).to set_flash[:success]
  end
end
