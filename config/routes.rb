# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
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
  get 'components/index'

  root 'homepage#index'
end
