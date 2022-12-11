# frozen_string_literal: true

require "./lib/server_side_rendering/asset_container.rb"

Rails.application.configure do
  config.react.server_renderer_pool_size  ||= 1  # ExecJS doesn't allow more than one on MRI
  config.react.server_renderer_timeout    ||= 20 # seconds

  config.react.server_renderer = React::ServerRendering::BundleRenderer

  config.react.server_renderer.asset_container_class = ServerSideRendering::AssetContainer

  config.react.server_renderer_options = {
    files: %w[application_common.js server_rendering.js], # files to load for prerendering
    replay_console: true # if true, console.* will be replayed client-side
  }

  # Changing files matching these dirs/exts will cause the server renderer to reload:
  config.react.server_renderer_extensions = %w[jsx js]
  config.react.server_renderer_directories = ["/app/javascript/front/components"]
end
