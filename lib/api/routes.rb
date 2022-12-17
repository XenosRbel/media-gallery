# frozen_string_literal: true

Api::Engine.routes.draw do # rubocop:disable Metrics/BlockLength
  namespace :v1 do # rubocop:disable Metrics/BlockLength
    defaults format: "json" do # rubocop:disable Metrics/BlockLength
      namespace :media_gallery do
        resources :items, only: :index
        resources :folders, only: %i[create update destroy]
        resources :files, except: %i[new edit] do
          collection do
            delete :destroy
          end
        end
      end
    end
  end
end
