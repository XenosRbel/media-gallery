# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::MediaGallery::Folder::Updater, type: :service do
  subject(:service) { described_class.new(contract: contract) }

  let(:object) { build_stubbed(:media_gallery_folder) }
  let(:contract) { instance_double(::MediaGallery::FolderContract) }
  let(:service_call) { service.call(folder_params: params, folder: object) }

  it_behaves_like :media_gallery_updater do
    let(:persistence_errors_class) { instance_double(Admin::MediaGallery::Folder::PersistenceErrors) }
    let(:persistence_errors) { build(:media_gallery_folder_persistence_errors, **errors_hash) }
  end
end
