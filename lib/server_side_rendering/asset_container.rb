# frozen_string_literal: true

module ServerSideRendering
  class AssetContainer < React::ServerRendering::WebpackerManifestContainer
    def find_asset(logical_path)
      super(logical_path).concat("\n")
    end
  end
end
