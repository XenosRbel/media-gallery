# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::MediaGallery::File::Updater, type: :service do
  subject(:service) { described_class.new(contract: contract) }

  let(:object) { build_stubbed(:media_gallery_file) }
  let(:contract) { instance_double(::MediaGallery::UpdaterFileContract) }
  let(:service_call) { service.call(file_params: params, file: object) }

  it_behaves_like :media_gallery_updater do
    let(:persistence_errors_class) { instance_double(Admin::MediaGallery::File::PersistenceErrors) }
    let(:persistence_errors) { build(:media_gallery_file_persistence_errors, **errors_hash) }
  end
end
